require "rails_helper"

RSpec.feature "User sign in" do
  before do
    @adam = User.create!(email: "adam@example.com", password: "haslo1")
  end

  scenario "with correct credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: "adam@example.com"
    fill_in "Password", with: "haslo1"
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Signed in as adam@example.com")
    expect(page).not_to have_link("Sign up")
    expect(page).not_to have_link("Sign in")

  end

end
