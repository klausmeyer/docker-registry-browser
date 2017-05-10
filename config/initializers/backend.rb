Rails.application.config.tap do |config|
  config.x.registry_url        = ENV["DOCKER_REGISTRY_URL"] || "http://localhost:5000"
  config.x.no_ssl_verification = ENV["NO_SSL_VERIFICATION"].in? %w(1 true yes)
  config.x.basic_auth_user     = Config.get("BASIC_AUTH_USER")
  config.x.basic_auth_password = Config.get("BASIC_AUTH_PASSWORD")
  config.x.delete_enabled      = ENV["ENABLE_DELETE_IMAGES"].in? %w(1 true yes)
end
