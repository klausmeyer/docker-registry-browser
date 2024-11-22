module ApplicationHelper
  def flash_css_class(type)
    {
      "notice" => "warning",
      "error"  => "danger"
    }.fetch(type, type)
  end

  def pull_command(repository, tag)
    "docker pull " + [ Rails.configuration.x.public_registry_url, repository ].join("/") + ":" + tag
  end
end
