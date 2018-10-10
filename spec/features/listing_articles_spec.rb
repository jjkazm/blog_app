require "rails_helper"

RSpec.feature "Listing Articles" do
  before do
    @article1 = Article.create(title: "This is first article", body: "This is body of first article")
    @article2 = Article.create(title: "This is second article", body: "This is body of second article")
  end

  scenario "List all articles" do
    visit "/"
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article2.title)
  end

  scenario "List article, when no articles present" do
    Article.delete_all

    visit "/"
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article2.title)

    within("h1#no-articles") do
      expect(page).to have_content("No articles yet")
    end
  end


end
