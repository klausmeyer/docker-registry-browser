version = ENV.fetch("SOURCE_VERSION", "v0.0.0").delete_prefix("v")

if sha = ENV["SOURCE_COMMIT"].presence
  version = "#{version} (#{sha[0...7]})"
end

Rails.application.config.x.version = version.freeze
