require "rails_helper"

feature "Tag details" do
  shared_examples_for "successful showing an image tag" do
    scenario "Show details of tag", :vcr do
      visit "/repo/test/hello-world"

      click_link "latest"

      expect(page).to have_content "Tag"
      expect(page).to have_content "hello-world:latest"

      expect(page).to have_content "Content Digest"
      expect(page.find_field("content_digest").value).to match /sha256:[0-9a-f]{64}/

      expect(page).to have_content "Size"
      expect(page).to have_content "743 KB"

      expect(page).to have_content "ENV"
      expect(page).to have_content "IMAGE=test/hello-world:latest"

      expect(page).to have_content "Labels"
      expect(page).to have_content "image\ntest/hello-world:latest"
      expect(page).to have_content "maintainer\nSomebody"

      expect(page).to have_content /Layers\n\[#000\] sha256:[0-9a-f]{64}/
    end
  end

  context "when the manifest is in oci v1 format" do
    include_examples "successful showing an image tag"
  end

  context "when the manifest is in docker v2 format" do
    include_examples "successful showing an image tag"
  end

  context "when the manifest is a list" do
    scenario "Show multiple manifests as tabs", :vcr do
      visit "/repo/test/hello-world"

      click_link "v1"

      expect(page).to have_content "linux / arm64"
      expect(page).to have_content "linux / amd64"
    end
  end
end
