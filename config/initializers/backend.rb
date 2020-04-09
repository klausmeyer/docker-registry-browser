require "config"

Rails.application.config.tap do |config|
  config.x.registry_url        = Config.get(name: "DOCKER_REGISTRY_URL", default: "http://localhost:5000")
  config.x.no_ssl_verification = Config.get(name: "NO_SSL_VERIFICATION").in? %w(1 true yes)
  config.x.ca_file             = Config.get(name: "CA_FILE")
  config.x.basic_auth_user     = Config.get(name: "BASIC_AUTH_USER", secret: true)
  config.x.basic_auth_password = Config.get(name: "BASIC_AUTH_PASSWORD", secret: true)
  config.x.token_auth_user     = Config.get(name: "TOKEN_AUTH_USER", secret: true)
  config.x.token_auth_password = Config.get(name: "TOKEN_AUTH_PASSWORD", secret: true)
  config.x.delete_enabled      = Config.get(name: "ENABLE_DELETE_IMAGES").in? %w(1 true yes)
  config.x.public_registry_url = Config.get(name: "PUBLIC_REGISTRY_URL")
  config.x.ssl_address         = Config.get(name: "SSL_ADDRESS", default: "0.0.0.0")
  config.x.ssl_port            = Config.get(name: "SSL_PORT", default: "8443")
  config.x.ssl_cert_path       = Config.get(name: "SSL_CERT_PATH")
  config.x.ssl_key_path        = Config.get(name: "SSL_KEY_PATH")
end
