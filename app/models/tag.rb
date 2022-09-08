class Tag < Resource
  include ActiveModel::Model

  ACCEPTED_MANIFEST_FORMATS = %w[
    application/vnd.oci.image.manifest.v1+json
    application/vnd.docker.distribution.manifest.list.v2+json
    application/vnd.docker.distribution.manifest.v2+json
    application/vnd.docker.distribution.manifest.v1+json
  ]

  attr_accessor :repository, :name, :content_digest, :manifests

  def self.find(repository:, name:)
    new(repository: repository, name: name)
  end

  def initialize(**args)
    super

    self.manifests = fetch_manifests.sort_by(&:architecture)
  end

  def delete
    client.delete("/v2/#{repository.name}/manifests/#{content_digest}").success?
  end

  private

  def fetch_manifest(reference)
    client.get("/v2/#{repository.name}/manifests/#{reference}") do |request|
      request.headers["Accept"] = ACCEPTED_MANIFEST_FORMATS.join(', ')
    end
  end

  def fetch_manifests
    main = fetch_manifest(name)

    self.content_digest = main.headers["docker-content-digest"]

    if list = main.body["manifests"]
      list.map do |entry|
        manifest_for_digest(fetch_manifest(entry.fetch("digest")).body)
      end
    else
      [manifest_for_digest(main.body)]
    end
  end

  def manifest_for_digest(manifest)
    digest = manifest.dig("config", "digest") or raise KeyError, "Missing config.digest"

    blob = client.get("/v2/#{repository.name}/blobs/#{digest}").body
    blob = JSON.parse(blob) if blob.instance_of?(String)

    layers = Array.wrap(manifest["layers"] || manifest["fsLayers"]).each_with_index.map do |layer, index|
      Layer.new(
        index:  index+1,
        digest: layer["digest"] || layer["blobSum"],
        size:   layer["size"]
      )
    end

    Manifest.new(
      architecture:   [blob.dig("architecture"), blob.dig("variant")].compact.join("-"),
      content_digest: digest,
      created:        (Time.parse(blob.dig("created")) rescue nil),
      env:            blob.dig("config", "Env") || [],
      history:        blob.fetch("history", []).map { |e| HistoryEntry.new(e) },
      labels:         blob.dig("config", "Labels") || {},
      layers:         layers,
      size:           layers.sum(&:size),
      os:             blob.dig("os"),
      repository:     repository,
    )
  end
end
