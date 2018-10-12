require "rails_helper"

RSpec.feature "Showing article" do
  before do
    @adam = User.create(email: "adam@example.com", password: "haslo1")
    @jurek = User.create(email: "jurek@example.com", password: "haslo1")

    @article = Article.create(title: "This is first article", body: "Ram pam pam", user: @adam)
  end
  scenario "A user shows an article when user is owner of the article" do
    login_as(@adam)
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "A user shows an article when user is owner of the article" do
    login_as(@jurek)
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "A user shows an article when visitor is NOT signed in" do
    visit "/"
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

end
