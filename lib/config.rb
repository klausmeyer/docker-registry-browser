module Config
  extend self

  def get(name:, default: nil, secret: false)
    if secret && File.file?("/run/secrets/#{name}")
      File.read("/run/secrets/#{name}").strip
    elsif ENV.key?(name)
      ENV[name]
    else
      default
    end
  end
end
