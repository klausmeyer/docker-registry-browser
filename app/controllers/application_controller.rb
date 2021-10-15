class ApplicationController < ActionController::Base
  rescue_from Faraday::ResourceNotFound, with: :not_found
  rescue_from Faraday::ClientError, with: :client_error

  before_action :set_current_auth

  private

  def set_current_auth
    Current.http_basic_auth = ActionController::HttpAuthentication::Basic.user_name_and_password(request)
    Current.http_token_auth = session[:registry_auth_token]
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def client_error(error)
    raise error unless error.response && error.response[:status] == 401

    case details = error.response.dig(:headers, 'www-authenticate')
    when /basic/i
      basic_authentication
    when /bearer/i
      token_authentication(details)
    else
      raise error
    end
  end

  def basic_authentication
    request_http_basic_authentication
  end

  def token_authentication(details)
    if token_authentication_credentials.present?
      obtain_authentication_token(details)
    else
      request_http_basic_authentication
    end
  end

  def token_authentication_credentials
    credentials = [
      Rails.configuration.x.token_auth_user,
      Rails.configuration.x.token_auth_password
    ]

    credentials.compact.presence || Current.http_basic_auth.presence
  end

  def obtain_authentication_token(details)
    auth_params = details[/\w+ (.*)/, 1]
    auth_params = Hash[auth_params.scan(/(\w+)="([^"]+)"/)]

    return if auth_attempts_exceeded? auth_params['scope']

    session[:registry_auth_scope] = auth_params['scope']
    session[:registry_auth_token] = ObtainAuthenticationToken.new(auth_params, token_authentication_credentials).call

    set_current_auth

    redirect_to request.fullpath if request.get?
  rescue ObtainAuthenticationToken::InvalidCredentials
    render 'errors/invalid_credentials'
  end

  def auth_attempts_exceeded?(scope)
    session[:registry_auth_attempts] = 0 if scope != session[:registry_auth_scope]
    session[:registry_auth_attempts] += 1

    return false if session[:registry_auth_attempts] <= 3

    render 'errors/auth_attempts_exceeded'
    true
  end
end
