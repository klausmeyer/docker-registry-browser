require_relative 'boot'

require 'config'
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DockerRegistryBrowser
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.x.registry_url        = ENV["DOCKER_REGISTRY_URL"] || "http://localhost:5000"
    config.x.no_ssl_verification = ENV["NO_SSL_VERIFICATION"].in? %w(1 true yes)
    config.x.basic_auth_user     = Config.get("BASIC_AUTH_USER")
    config.x.basic_auth_password = Config.get("BASIC_AUTH_PASSWORD")
    config.x.delete_enabled      = ENV["ENABLE_DELETE_IMAGES"].in? %w(1 true yes)
  end
end
