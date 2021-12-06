class Manifest
  include ActiveModel::Model

  attr_accessor(
    :architecture,
    :content_digest,
    :created,
    :env,
    :history,
    :labels,
    :layers,
    :size,
    :name,
    :os,
    :repository,
  )

  def id
    [os, architecture].join("-")
  end

  def delete
    client.delete("/v2/#{repository.name}/manifests/#{content_digest}").success?
  end
end
