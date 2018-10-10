require "rails_helper"

RSpec.feature "Editing Article" do
  before do
    @article = Article.create(title: "To be updated", body: "This also should be updated")
  end
  scenario "A user edits article" do
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: "Updated title"
    click_button "Update Article"
    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "A user fails editing article" do
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: ""
    click_button "Update Article"
    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

end
