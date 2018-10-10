require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @article = Article.create(title: "Test article", body: "Test article body")
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
        expect(flash[:alert]).to eq flash_message

      end
    end

  end
end
