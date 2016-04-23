class Repository < Resource
  include ActiveModel::Model

  attr_accessor :name, :tags

  def self.all
    response = client.get "/v2/_catalog"
    response.body["repositories"].map { |name| new(name: name) }
  end

  def self.find(name)
    response = client.get "/v2/#{name}/tags/list"
    new(
      name: response.body["name"],
      tags: Array.wrap(response.body["tags"])
    )
  end

  def namespace(root = "<root>")
    name.split("/").size == 1 ? root : name.split("/").first
  end

  def image
    name.split("/").last
  end
end

