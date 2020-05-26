class ApplicationController < ActionController::Base
  rescue_from Faraday::ResourceNotFound, with: :not_found
  rescue_from Faraday::ClientError, with: :client_error

  before_action do
    Current.http_basic_auth = ActionController::HttpAuthentication::Basic.user_name_and_password(request)
    Current.http_token_auth = session[:registry_auth_token]
  end

  private

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def client_error(error)
    if error.response && error.response[:status] == 401
      case details = error.response.dig(:headers, 'www-authenticate')
      when /basic/i
        request_http_basic_authentication
      when /bearer/i
        perform_token_authentication(details)
      else
        raise
      end
    else
      raise
    end
  end

  def perform_token_authentication(details)
    auth_params = details[/\w+ (.*)/, 1]
    auth_params = Hash[auth_params.scan(/(\w+)="([^"]+)"/)]

    return if auth_attempts_exceeded? auth_params['scope']

    session[:registry_auth_scope] = auth_params['scope']
    session[:registry_auth_token] = ObtainAuthenticationToken.new(auth_params).call
    redirect_to request.fullpath
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
