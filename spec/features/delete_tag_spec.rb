require "rails_helper"

feature "Tag details" do
  background do
    allow(Rails.configuration.x).to receive(:delete_enabled) { true }
  end

  scenario "Delete tag", :vcr, :js do
    visit "/repo/hello-world/tag/latest"

    expect(page).to have_content "Namespace: <root> / Image: hello-world / Tag: latest"
    expect(page).to have_content "Danger Zone"
    click_link "Delete"

    expect(page).to have_selector("#delete-dialog", visible: true)
    expect(page).to have_content "Please type in the name of the tag"
    fill_in "delete_confirm", with: "latest"
    click_link "Yes I'm sure"

    expect(page).to have_content "The tag latest has been deleted."
  end
end
