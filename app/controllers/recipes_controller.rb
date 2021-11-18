class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    scope = RecipesSearchService.call(search_params)
    @recipes = scope.order(sort).page(params[:page])
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(*permitted_attributes)
    end

  def permitted_attributes
    [:rate, :author_tip, :prep_time, :budget, :name, :difficulty, :people_quantity, :cook_time, :total_time,
     :nb_comments, :image, :tags, :ingredients, :author]
  end

  def search_params
    @search_params ||= compute_search_params
  end

  def compute_search_params
    params_object = params[:search] || ActionController::Parameters.new
    params_object.permit(*permitted_attributes).to_h
  end

  def sort
    sort_params = params.permit(:sort_column, :sort_direction)
    @sort_column = sort_params[:sort_column] || 'name'
    @sort_direction = sort_params[:sort_direction] || 'asc'
    "#{@sort_column} #{@sort_direction}"
  end
end
