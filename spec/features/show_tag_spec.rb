require "rails_helper"

feature "Tag details" do
  scenario "Show details of tag", :vcr do
    visit "/repo/test/hello-world"

    click_link "latest"

    expect(page).to have_content "Tag"
    expect(page).to have_content "hello-world:latest"

    expect(page).to have_content "Content Digest"
    expect(page.find_field("content_digest").value).to match /sha256:[0-9a-f]{64}/

    expect(page).to have_content "ENV"
    expect(page).to have_content "IMAGE=test/hello-world:latest"

    expect(page).to have_content "Labels"
    expect(page).to have_content "image\ntest/hello-world:latest"
    expect(page).to have_content "maintainer\nSomebody"

    expect(page).to have_content /Layers\n001 sha256:[0-9a-f]{64}/
  end
end
