require "rails_helper"

RSpec.feature "Deleting Article" do
  before do
    @adam = User.create(email: "adam@example.com", password: "haslo1")
    login_as(@adam)
    @article = Article.create(title:"This is title", body: "This is body", user: @adam)
  end

  scenario "A user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
