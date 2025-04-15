require "rails_helper"

feature "Image details" do
  scenario "Show details of image", :vcr do
    visit "/"

    click_link "hello-world", match: :first

    expect(page).to have_content "Repository"
    expect(page).to have_content "hello-world"
    expect(page).to have_content "TAG v2\nTAG v1\nTAG latest"
  end

  scenario "Use custom sort for tags", :vcr do
    visit "/repo/hello-world?sort_tags_by=api&sort_tags_order=asc"

    expect(page).to have_content "TAG v2\nTAG latest\nTAG v1"
  end
end
