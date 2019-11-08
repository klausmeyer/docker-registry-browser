require "rails_helper"

feature "Image details" do
  scenario "Show details of image", :vcr do
    visit "/"

    click_link "hello-world", match: :first

    expect(page).to have_content "Namespace"
    expect(page).to have_content "/"
    expect(page).to have_content "Image"
    expect(page).to have_content "hello-world"
    expect(page).to have_content "latest"
    expect(page).to have_content "v1"
    expect(page).to have_content "v2"
  end
end
