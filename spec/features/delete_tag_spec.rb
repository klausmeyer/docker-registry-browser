require "rails_helper"

feature "Delete Tags" do
  background do
    allow(Rails.configuration.x).to receive(:delete_enabled).and_return(true)
  end

  scenario "Successfully delete a tag", :vcr do
    visit "/repo/hello-world/tag/delete-me"

    expect(page).to have_content "Tag"
    expect(page).to have_content "hello-world:delete-me"

    expect(page).to have_content "Danger Zone"
    within ".border-danger" do
      click_link "Delete"
    end

    expect(page).to have_selector("#delete-dialog", visible: true)
    expect(page).to have_content "This will permanently delete the "
    fill_in "delete_confirm", with: "delete-me"
    within "#delete-dialog" do
      click_link "Delete"
    end

    expect(page).to have_content "The tag delete-me has been deleted."
  end

  scenario "Successfully delete a tag with token based auth", :vcr do
    allow(Rails.configuration.x).to receive(:token_auth_user).and_return('admin')
    allow(Rails.configuration.x).to receive(:token_auth_password).and_return('password')

    visit "/repo/hello-world/tag/delete-me"

    expect(page).to have_content "Tag"
    expect(page).to have_content "hello-world:delete-me"

    expect(page).to have_content "Danger Zone"
    within ".border-danger" do
      click_link "Delete"
    end

    expect(page).to have_selector("#delete-dialog", visible: true)
    expect(page).to have_content "This will permanently delete the "
    fill_in "delete_confirm", with: "delete-me"
    within "#delete-dialog" do
      click_link "Delete"
    end

    expect(page).to have_content "The tag delete-me has been deleted."
  end

  scenario "Deletion blocked by registry", :vcr do
    visit "/repo/hello-world/tag/delete-me"

    expect(page).to have_content "Tag"
    expect(page).to have_content "hello-world:delete-me"

    expect(page).to have_content "Danger Zone"
    within ".border-danger" do
      click_link "Delete"
    end

    expect(page).to have_selector("#delete-dialog", visible: true)
    expect(page).to have_content "This will permanently delete the "
    fill_in "delete_confirm", with: "delete-me"
    within "#delete-dialog" do
      click_link "Delete"
    end

    expect(page).to have_content "The delete request was blocked by the registry."
  end
end
