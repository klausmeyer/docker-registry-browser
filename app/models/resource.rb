class Resource
  private

  def self.client
    Faraday.new(url: Rails.configuration.x.registry_url, ssl: { verify: !Rails.configuration.x.no_ssl_verification }) do |f|
      if Rails.configuration.x.basic_auth_user && Rails.configuration.x.basic_auth_password
        f.use Faraday::Request::BasicAuthentication,
          Rails.configuration.x.basic_auth_user,
          Rails.configuration.x.basic_auth_password
      elsif (auth = Current.http_basic_auth).present?
        f.use Faraday::Request::BasicAuthentication, *auth
      elsif (token = Current.http_token_auth).present?
        f.request :oauth2, token, token_type: :bearer
      end
      f.use FaradayMiddleware::ParseJson, content_type: /json|prettyjws/
      f.response :logger unless Rails.env.test?
      f.response :raise_error
      f.adapter  Faraday.default_adapter
    end
  end

  def client
    self.class.client
  end
end
