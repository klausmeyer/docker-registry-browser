require "rails_helper"

feature "Image details" do
  scenario "Show details of image", :vcr do
    visit "/"

    click_link "hello-world", match: :first

    expect(page).to have_content "Namespace"
    expect(page).to have_content "/"
    expect(page).to have_content "Image"
    expect(page).to have_content "hello-world"
    expect(page).to have_content "Tag v2\nTag v1\nTag latest"
  end

  scenario "Use custom sort for tags", :vcr do
    visit "/repo/hello-world?sort_tags_by=api&sort_tags_order=asc"

    expect(page).to have_content "Tag v2\nTag latest\nTag v1"
  end
end
