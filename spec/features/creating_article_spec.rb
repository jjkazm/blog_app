require "rails_helper"

RSpec.feature "Creating Articles" do
  before do
    @adam = User.create!(email: "adam@example.com", password: "haslo1")
    login_as(@adam)
  end
  scenario "A user creates a new article" do
    visit "/"
    click_link "New Article"
    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Create Article"
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by #{ @adam.email }")
  end

  scenario "User fails creating article with empty fields" do
    visit "/"
    click_link "New Article"
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Create Article"
    expect(page).to have_content("Article hasn't been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
