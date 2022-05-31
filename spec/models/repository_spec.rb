require "rails_helper"

describe Repository do
  describe ".all" do
    it "returns a list of repositories" do
      VCR.use_cassette("repository/all") do
        list = Repository.list
        repo = list.first
        expect(list).to be_instance_of Collection
        expect(repo).to be_instance_of Repository
        expect(repo.name).to eq "hello-world"
      end
    end

    it "returns an empty list when repositories returned as null" do
      VCR.use_cassette("repository/null") do
        expect(Repository.list.entries).to eq []
      end
    end
  end

  describe ".find" do

    context "for a existing repo" do
      let(:name) { "test/hello-world-1" }

      it "returns one repository including tags on successful response" do
        VCR.use_cassette("repository/find_success") do
          repo = Repository.find name
          expect(repo).to be_instance_of Repository
          expect(repo.name).to eq name
          expect(repo.tags).to eq %w(latest)
        end
      end
    end

    context "for a unknown repo" do
      let(:name) { "unknown/one" }

      it "returns one returns without tags on 404 response" do
        VCR.use_cassette("repository/find_not_found") do
          repo = Repository.find name
          expect(repo).to be_instance_of Repository
          expect(repo.name).to eq name
          expect(repo.tags).to eq []
        end
      end
    end
  end

  describe "#namespace" do
    subject { Repository.new(name: name) }

    context "when the name contains a namespace and image" do
      let(:name) { "randomguy1/image1" }

      it "returns just the namespace part" do
        expect(subject.namespace).to eq "randomguy1"
      end
    end

    context "when the name contains a namespace (with slash) and image" do
      let(:name) { "department/randomguy1/image1" }

      it "returns just the namespace part" do
        expect(subject.namespace).to eq "department/randomguy1"
      end
    end

    context "when the name contains only a image" do
      let(:name)  { "image1" }
      let(:label) { "custom-label" }

      context "when a custom root label is passed" do
        it "returns the passed root label" do
          expect(subject.namespace label).to eq label
        end
      end

      context "when no custom root label is passed" do
        it "returns empty string" do
          expect(subject.namespace).to eq ""
        end
      end
    end
  end

  describe "#image" do
    subject { Repository.new(name: name) }

    context "when the name contains a namespace and image" do
      let(:name) { "randomguy1/image1" }

      it "returns the image name" do
        expect(subject.image).to eq "image1"
      end
    end

    context "when the name contains only a image" do
      let(:name) { "image1" }

      it "returns the image name" do
        expect(subject.image).to eq "image1"
      end
    end
  end
end
