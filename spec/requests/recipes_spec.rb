require 'rails_helper'

RSpec.describe "/recipes", type: :request do
  let(:valid_recipe) {
    create(:recipe)
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  describe "GET /index" do
    it "renders a successful response" do
      valid_recipe
      get recipes_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get recipe_url(valid_recipe)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_recipe_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_recipe_url(valid_recipe)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with invalid parameters" do
      it "does not create a new Recipe" do
        expect {
          post recipes_url, params: { recipe: invalid_attributes }
        }.to change(Recipe, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post recipes_url, params: { recipe: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Pizza!' }
      }

      it "updates the requested recipe" do
        recipe = valid_recipe
        patch recipe_url(recipe), params: { recipe: new_attributes }
        recipe.reload
        expect(recipe.name).to eq(new_attributes[:name])
      end

      it "redirects to the recipe" do
        recipe = valid_recipe
        patch recipe_url(recipe), params: { recipe: new_attributes }
        recipe.reload
        expect(response).to redirect_to(recipe_url(recipe))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        recipe = valid_recipe
        patch recipe_url(recipe), params: { recipe: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested recipe" do
      recipe = valid_recipe
      expect {
        delete recipe_url(recipe)
      }.to change(Recipe, :count).by(-1)
    end

    it "redirects to the recipes list" do
      recipe = valid_recipe
      delete recipe_url(recipe)
      expect(response).to redirect_to(recipes_url)
    end
  end
end
