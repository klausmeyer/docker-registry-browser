require "rails_helper"

feature "Image listing" do
  scenario "Showing the list of available images", :vcr do
    visit "/"

    expect(page).to have_content "Namespace"
    expect(page).to have_content "/"
    expect(page).to have_content "IMG"
    expect(page).to have_content "hello-world"

    expect(page).to have_content "test"
    expect(page).to have_content "hello-world"
    expect(page).to have_content "hello-world-2"
    expect(page).to have_content "hello-world-3"
  end
end
