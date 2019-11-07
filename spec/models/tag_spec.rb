require "rails_helper"

describe Tag do
  let(:repo) { Repository.new(name: "test/hello-world") }

  describe ".find" do
    let(:name) { "latest" }
    
    it "returns one repository" do
      VCR.use_cassette("tag/find") do
        tag = Tag.find repository: repo, name: name
        expect(tag).to be_instance_of Tag
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
