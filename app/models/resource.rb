class Resource
  private

  def self.client
    @client ||= begin
      options = { url: Rails.configuration.x.registry_url }
      options.merge!(ssl: { verify: false }) if Rails.configuration.x.no_ssl_verification
      Faraday.new(options) do |f|
        f.request  :url_encoded
        f.response :logger unless Rails.env.test?
        f.response :raise_error
        f.adapter  Faraday.default_adapter
        f.use FaradayMiddleware::ParseJson, content_type: /json|prettyjws/
      end
    end
  end

  def client
    self.class.client
  end
end
