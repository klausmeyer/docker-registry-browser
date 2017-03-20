require "rails_helper"

feature "Tag details" do
  scenario "Show details of tag", :vcr do
    visit "/repo/test/hello-world"

    click_link "Tag: latest"

    expect(page).to have_content "Namespace: test / Image: hello-world / Tag: latest"
    expect(page).to have_content "Content Digest"
    expect(page).to have_content "sha256:2075ac87b043415d35bb6351b4a59df19b8ad154e578f7048335feeb02d0f759"

    expect(page).to have_content "Layer"
    expect(page).to have_content "sha256:983bfa07a342e316f08afd066894505088de985d46a9af743920aa9cafd17e7a"
    expect(page).to have_content "979 Bytes"
  end
end

