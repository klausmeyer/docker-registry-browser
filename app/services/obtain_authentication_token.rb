class ObtainAuthenticationToken
  InvalidCredentials = Class.new(RuntimeError)

  def initialize(auth_params)
    @realm   = auth_params.fetch('realm')
    @service = auth_params.fetch('service')
    @scope   = auth_params.fetch('scope')
  end

  def call
    perform_request
  end

  private

  attr_accessor :realm, :service, :scope

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
    Faraday.new url: realm, ssl: { verify: !Rails.configuration.x.no_ssl_verification } do |f|
      f.use Faraday::Request::BasicAuthentication,
        Rails.configuration.x.token_auth_user,
        Rails.configuration.x.token_auth_password
      f.use FaradayMiddleware::ParseJson, content_type: /json|prettyjws/
      f.response :logger unless Rails.env.test?
      f.response :raise_error
      f.adapter Faraday.default_adapter
    end
  end
end
