class Repository < Resource
  include ActiveModel::Model

  attr_accessor :name, :tags

  def self.list(count: 100, last: nil)
    response = client.get "/v2/_catalog", { n: count, last: last }.compact
    entries  = response.body["repositories"].map { |name| new(name: name) }

    Collection.new entries: entries, more: response.headers.has_key?("Link")
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

