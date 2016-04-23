class Resource
  private

  def self.client
    @client ||= begin
      Faraday.new(url: Rails.configuration.x.registry_url) do |f|
        f.request  :url_encoded
        f.response :logger
        f.response :raise_error
        f.adapter  Faraday.default_adapter
        f.use FaradayMiddleware::ParseJson, content_type: /json/
      end
    end
  end

  def client
    self.class.client
  end
end