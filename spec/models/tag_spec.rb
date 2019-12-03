require "rails_helper"

describe Tag do
  let(:repo) { Repository.new(name: "test/hello-world") }

  describe ".find" do
    let(:name) { "latest" }

    context "with a repository returning non-json content type for meta blob" do
      let(:blob_content_type) { "application/octet-stream" }

      it "returns one repository" do
        VCR.use_cassette("tag/find", erb: {blob_content_type: blob_content_type}) do
          tag = Tag.find repository: repo, name: name
          expect(tag).to be_instance_of Tag
        end
      end
    end

    context "with a repository returning json content type for meta blob" do
      let(:blob_content_type) { "application/vnd.docker.container.image.v1+json" }

      it "returns one repository" do
        VCR.use_cassette("tag/find", erb: {blob_content_type: blob_content_type}) do
          tag = Tag.find repository: repo, name: name
          expect(tag).to be_instance_of Tag
        end
      end
    end
  end

  describe "#delete" do
    let(:name) { "delete-me" }

    it "returns true" do
      VCR.use_cassette("tag/delete") do
        tag = Tag.find repository: repo, name: name
        expect(tag.delete).to be true
      end
    end
  end
end
