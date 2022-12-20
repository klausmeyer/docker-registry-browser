class Resource
  private

  def self.client
    Faraday.new(url: Rails.configuration.x.registry_url, ssl: ssl_options) do |f|
      if Rails.configuration.x.basic_auth_user && Rails.configuration.x.basic_auth_password
        f.use Faraday::Request::BasicAuthentication,
          Rails.configuration.x.basic_auth_user,
          Rails.configuration.x.basic_auth_password
      elsif (token = Current.http_token_auth).present?
        f.request :oauth2, token, token_type: :bearer
      elsif (auth = Current.http_basic_auth).present?
        f.use Faraday::Request::BasicAuthentication, *auth
      end
      f.use FaradayMiddleware::FollowRedirects, limit: 5
      f.use FaradayMiddleware::ParseJson, content_type: /json|prettyjws/
      f.response :logger, Rails.configuration.logger, Rails.configuration.x.registry_log_options
      f.response :raise_error
      f.adapter  Faraday.default_adapter
    end
  end

  def self.ssl_options
    {
      verify:  Rails.configuration.x.no_ssl_verification.!,
      ca_file: Rails.configuration.x.ca_file
    }.compact
  end

  def client
    self.class.client
  end
end
