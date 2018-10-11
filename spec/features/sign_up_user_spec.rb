require "rails_helper"

RSpec.feature "Sign up user" do
  scenario "A user signs up succesfully" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "example@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "A user fails signing up" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"

    #expect(page).to have_content("You have not signed up successfully.")
  end
end







#
# RSpec.feature "Creating Articles" do
#   scenario "A user creates a new article" do
#     visit "/"
#     click_link "New Article"
#     fill_in "Title", with: "Creating a blog"
#     fill_in "Body", with: "Lorem Ipsum"
#     click_button "Create Article"
#     expect(page).to have_content("Article has been created")
#     expect(page.current_path).to eq(articles_path)
#   end
