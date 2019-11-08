require "rails_helper"

feature "Tag details" do
  background do
    allow(Rails.configuration.x).to receive(:delete_enabled) { true }
  end

  scenario "Delete tag", :vcr do
    visit "/repo/hello-world/tag/delete-me"

    expect(page).to have_content "Tag"
    expect(page).to have_content "hello-world:delete-me"

    expect(page).to have_content "Danger Zone"
    click_link "Delete Tag…"

    expect(page).to have_selector("#delete-dialog", visible: true)
    expect(page).to have_content "This will permanently delete the "
    fill_in "delete_confirm", with: "delete-me"
    click_link "Delete Tag"

    expect(page).to have_content "The tag delete-me has been deleted."
  end
end
