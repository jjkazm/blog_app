require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @adam = User.create(email: "adam@example.com", password: "haslo1")
    @jurek = User.create(email: "jurek@ogorek.com", password: "haslo1")
    @article = Article.create(title: "Test article", body: "Test article body", user: @adam)
  end

  describe 'GET/articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{ @article.id }" }

      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existin article' do
      before { get "/articles/xxxxxx"}

      it "handles non-existing article" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for can't be found"
        expect(flash[:danger]).to eq flash_message
      end
    end
  end

  describe "GET/articles/:id/edit" do
    context "with NOT signed visitor" do
      before { get "/articles/#{ @article.id}/edit"}
      it "redirects to signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to be logged in to edit articles. Sign in or sign up."
        expect(flash[:danger]).to eq flash_message
      end
    end

    context "with non-owner user" do
      before do
        login_as(@jurek)
        get "/articles/#{ @article.id}/edit"
      end
      it "redirects to signinpage" do
        expect(response.status).to eq 302
        flash_message = "You need to be the author to edit articles."
        expect(flash[:danger]).to eq flash_message
      end
    end

    context "with user who is author of the article" do
      before do
        login_as(@adam)
        get "/articles/#{ @article.id}/edit"
      end
      it "succesfully renders edit form" do
        expect(response.status).to eq 200
      end
    end
  end
end
