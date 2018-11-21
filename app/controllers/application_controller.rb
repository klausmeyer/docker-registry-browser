class ApplicationController < ActionController::Base
  rescue_from Faraday::ResourceNotFound, with: :not_found
  rescue_from Faraday::ClientError, with: :client_error

  before_action do
    Current.http_basic_auth = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
  end

  private

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def client_error(error)
    if error.response &&
      error.response[:status] == 401 &&
      error.response.dig(:headers, 'www-authenticate') =~ /basic/i

      request_http_basic_authentication
    else
      raise
    end
  end
end
