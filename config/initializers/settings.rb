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
  config.x.collapse_namespaces = Config.get(name: "ENABLE_COLLAPSE_NAMESPACES").in? %w(1 true yes)
  config.x.sort_tags_by        = Config.get(name: "SORT_TAGS_BY", default: "name", allow: %w(api name version))
  config.x.sort_tags_order     = Config.get(name: "SORT_TAGS_ORDER", default: "desc", allow: %w(asc desc))

  # Configure Faraday logger options
  config.x.registry_log_options = {
    # Log level must be included by main application log level. E.g. if application log level
    # is set to :info, and this is set to :debug, no requests will be logged.
    log_level: Config.get(name: "REGISTRY_LOG_LEVEL", default: "info").to_sym,
    # Warning - enabling this results in sensitive data such as Authorization headers being logged
    headers: (Config.get(name: "REGISTRY_LOG_HEADERS", default: "false").in? %w(1 true yes))
  }
end
