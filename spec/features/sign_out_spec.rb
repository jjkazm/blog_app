require "rails_helper"

RSpec.feature "Sign out user" do
  before do
    @adam = User.create!(email: "adam@example.com", password: "haslo1")

    visit "/"
    click_link "Sign in"
    fill_in "Email", with: "adam@example.com"
    fill_in "Password", with: "haslo1"
    click_button "Log in"
  end

  scenario "succesfull signout" do
    visit "/"
    click_link "Sign out"

    expect(page).to have_content("Signed out successfully.")
    expect(page).not_to have_content("Sign out")
  end

end
