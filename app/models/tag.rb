class Tag < Resource
  include ActiveModel::Model

  attr_accessor(
    :architecture,
    :content_digest,
    :created,
    :env,
    :history,
    :labels,
    :layers,
    :name,
    :os,
    :repository
  )

  def self.find(repository:, name:)
    tag = client.get "/v2/#{repository.name}/manifests/#{name}" do |request|
      request.headers["Accept"] = "application/vnd.docker.distribution.manifest.v2+json"
    end

    details = client.get("/v2/#{repository.name}/blobs/#{tag.body.dig('config', 'digest')}").body
    details = JSON.parse(details) if details.instance_of?(String)

    layers = if tag.headers["content-type"] =~ /v2/
      Array.wrap(tag.body["layers"]).each_with_index.map do |layer, index|
        Layer.new(
          index:  index+1,
          digest: layer["digest"],
          size:   layer["size"]
        )
      end
    else
      Array.wrap(tag.body["fsLayers"]).each_with_index.map do |layer, index|
        Layer.new(
          index:  index+1,
          digest: layer["blobSum"]
        )
      end
    end

    created = Time.parse(details.dig("created")) rescue nil

    new(
      architecture:   details.dig("architecture"),
      content_digest: tag.headers["docker-content-digest"],
      created:        created,
      env:            details.dig("config", "Env") || [],
      labels:         details.dig("config", "Labels") || {},
      layers:         layers,
      history:        details.dig("history").map { |e| HistoryEntry.new(e) } || [],
      name:           name,
      os:             details.dig("os"),
      repository:     repository
    )
  end

  def delete
    client.delete "/v2/#{repository.name}/manifests/#{content_digest}"
    true
  end
end
