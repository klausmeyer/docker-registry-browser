require "rails_helper"

feature "Tag details" do
  background do
    allow(Rails.configuration.x).to receive(:delete_enabled) { true }
  end

  scenario "Delete tag", :vcr do
    visit "/repo/hello-world/tag/latest"

    expect(page).to have_content "Image"
    expect(page).to have_content "hello-world"

    expect(page).to have_content "Tag"
    expect(page).to have_content "latest"

    expect(page).to have_content "Danger Zone"
    click_link "Delete Tag…"

    expect(page).to have_selector("#delete-dialog", visible: true)
    expect(page).to have_content "This will permanently delete the "
    fill_in "delete_confirm", with: "latest"
    click_link "Delete Tag"

    expect(page).to have_content "The tag latest has been deleted."
  end
end
