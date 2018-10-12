require "rails_helper"

RSpec.feature "Listing Articles" do
  before do
    @adam = User.create(email: "adam@example.com", password: "haslo1")
    @article1 = Article.create(title: "This is first article", body: "This is body of first article", user: @adam)
    @article2 = Article.create(title: "This is second article", body: "This is body of second article", user: @adam)
  end

  scenario "List all articles when user logged in" do
    visit "/"
    login_as(@adam)
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
  end

  scenario "List all articles when user is NOT logged in" do
    visit "/"
    login_as(@adam)
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link("New Article")
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
