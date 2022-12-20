class ObtainAuthenticationToken
  InvalidCredentials = Class.new(RuntimeError)

  def initialize(auth_params, creds)
    @realm   = auth_params.fetch('realm')
    @service = auth_params.fetch('service')
    @scope   = auth_params.fetch('scope')
    @creds   = creds
  end

  def call
    perform_request
  end

  private

  attr_accessor :realm, :service, :scope, :creds

  def perform_request
    resp = client.get(realm, params)
    resp.body['token'] || resp.body['access_token']
  rescue Faraday::ClientError => e
    raise InvalidCredentials if e.response[:status] == 401
    raise e
  end

  def params
    {
      service:       service,
      scope:         scope,
      offline_token: true,
      client_id:     'docker-registry-browser'
    }
  end

  def client
    Faraday.new url: realm, ssl: ssl_options do |f|
      f.use Faraday::Request::BasicAuthentication, *creds
      f.use FaradayMiddleware::ParseJson, content_type: /json|prettyjws/
      f.response :logger, Rails.configuration.logger, Rails.configuration.x.registry_log_options
      f.response :raise_error
      f.adapter Faraday.default_adapter
    end
  end

  def ssl_options
    {
      verify:  Rails.configuration.x.no_ssl_verification.!,
      ca_file: Rails.configuration.x.ca_file
    }.compact
  end
end
