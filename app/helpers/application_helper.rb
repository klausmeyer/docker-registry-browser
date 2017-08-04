module ApplicationHelper
  
  def get_pull_command(repository, tag = "latest")
    return "docker pull " + [Rails.configuration.x.public_registry_url, repository].join("/") + ":" + tag
  end
end
