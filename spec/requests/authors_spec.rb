require 'rails_helper'

RSpec.describe "/authors", type: :request do
  let(:valid_author) {
    create(:author)
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  describe "GET /index" do
    it "renders a successful response" do
      valid_author
      get authors_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      author = valid_author
      get author_url(author)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_author_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      author = valid_author
      get edit_author_url(author)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with invalid parameters" do
      it "does not create a new Author" do
        expect {
          post authors_url, params: { author: invalid_attributes }
        }.to change(Author, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post authors_url, params: { author: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: Faker::Name.unique.name }
      }

      it "updates the requested author" do
        author = valid_author
        patch author_url(author), params: { author: new_attributes }
        author.reload
        expect(author.name).to eq(new_attributes[:name])
      end

      it "redirects to the author" do
        author = valid_author
        patch author_url(author), params: { author: new_attributes }
        author.reload
        expect(response).to redirect_to(author_url(author))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        author = valid_author
        patch author_url(author), params: { author: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested author" do
      author = valid_author
      expect {
        delete author_url(author)
      }.to change(Author, :count).by(-1)
    end

    it "redirects to the authors list" do
      author = valid_author
      delete author_url(author)
      expect(response).to redirect_to(authors_url)
    end
  end
end
