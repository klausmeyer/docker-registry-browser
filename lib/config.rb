module Config
  extend self

  def get(name)
    if File.file?("/run/secrets/#{name}")
      File.read("/run/secrets/#{name}").strip
    else
      ENV[name]
    end
  end
end
