require "rails_helper"

describe Repository do
  describe ".all" do
    it "returns a list of repositories" do
      VCR.use_cassette("repository/all") do
        list = Repository.all
        repo = list.first
        expect(list).to be_instance_of Array
        expect(repo).to be_instance_of Repository
        expect(repo.name).to eq "image1"
      end
    end
  end

  describe ".find" do
    let(:name) { "randomguy1/image1" }

    it "returns one repository" do
      VCR.use_cassette("repository/find") do
        repo = Repository.find name
        expect(repo).to be_instance_of Repository
        expect(repo.name).to eq name
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

    context "when the name contains only a image" do
      let(:name)  { "image1" }
      let(:label) { "custom-label" }

      context "when a custom root label is passed" do
        it "returns the passed root label" do
          expect(subject.namespace label).to eq label
        end
      end

      context "when no custom root label is passed" do
        it "returns <root>" do
          expect(subject.namespace).to eq "<root>"
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
