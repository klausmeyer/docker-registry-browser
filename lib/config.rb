module Config
  extend self

  def get(name:, default: nil, secret: false, allow: nil)
    value = if secret && File.file?("/run/secrets/#{name}")
      File.read("/run/secrets/#{name}").strip
    elsif ENV.key?(name)
      ENV[name]
    else
      default
    end

    raise ArgumentError, "#{name} must be one of #{allow}" if allow.is_a?(Array) && !value.in?(allow)

    value
  end
end
