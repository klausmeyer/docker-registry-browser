Rails.application.config.x.version = "1.6.0"

# Docker Cloud will pass the git commit it is building the image from
# See: https://docs.docker.com/docker-hub/builds/advanced/
if sha = ENV["SOURCE_COMMIT"].presence
  Rails.application.config.x.version << " (#{sha[0...7]})"
end
