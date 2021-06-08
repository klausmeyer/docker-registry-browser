class Tag < Resource
  include ActiveModel::Model

  ACCEPTED_MANIFEST_FORMATS = %w[
    application/vnd.oci.image.manifest.v1+json
    application/vnd.docker.distribution.manifest.v2+json
    application/vnd.docker.distribution.manifest.v1+json
  ].freeze

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
    :repository,
    :type,
  )

  def self.find(repository:, name:)
    manifest = client.get "/v2/#{repository.name}/manifests/#{name}" do |request|
      request.headers["Accept"] = ACCEPTED_MANIFEST_FORMATS.join(', ')
    end

    digest = manifest.body.dig('config', 'digest') or raise KeyError, 'Missing config.digest'

    blob = client.get("/v2/#{repository.name}/blobs/#{digest}").body
    blob = JSON.parse(blob) if blob.instance_of?(String)

    layers = Array.wrap(manifest.body["layers"] || manifest.body["fsLayers"]).each_with_index.map do |layer, index|
      Layer.new(
        index:  index+1,
        digest: layer["digest"] || layer["blobSum"],
        size:   layer["size"]
      )
    end

    new(
      architecture:   blob.dig("architecture"),
      content_digest: manifest.headers["docker-content-digest"],
      created:        (Time.parse(blob.dig("created")) rescue nil),
      env:            blob.dig("config", "Env") || [],
      history:        blob.dig("history").map { |e| HistoryEntry.new(e) },
      labels:         blob.dig("config", "Labels") || {},
      layers:         layers,
      name:           name,
      os:             blob.dig("os"),
      repository:     repository,
      type:           manifest.headers["content-type"],
    )
  end

  def delete
    client.delete("/v2/#{repository.name}/manifests/#{content_digest}").success?
  end
end
