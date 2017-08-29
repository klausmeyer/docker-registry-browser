module ApplicationHelper  
  def pull_command(repository, tag)
    "docker pull " + [Rails.configuration.x.public_registry_url, repository].join("/") + ":" + tag
  end
end
