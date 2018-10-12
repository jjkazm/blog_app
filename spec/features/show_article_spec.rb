require "rails_helper"

RSpec.feature "Showing article" do
  before do
    @adam = User.create(email: "adam@example.com", password: "haslo1")
    login_as(@adam)
    @article = Article.create(title: "This is first article", body: "Ram pam pam", user: @adam)
  end
  scenario "A user shows an article" do
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end

end
