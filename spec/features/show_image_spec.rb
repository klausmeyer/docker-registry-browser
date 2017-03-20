require "rails_helper"

feature "Image details" do
  scenario "Show details of image", :vcr do
    visit "/"

    within :css, ".panel:nth-child(2)" do
      click_link "Image: hello-world"
    end

    expect(page).to have_content "Namespace: test / Image: hello-world"
    expect(page).to have_content "Tag: latest"
    expect(page).to have_content "Tag: v1"
    expect(page).to have_content "Tag: v2"
    expect(page).to have_content "Tag: v3"
  end
end

