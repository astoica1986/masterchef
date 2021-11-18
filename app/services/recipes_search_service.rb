class RecipesSearchService < BaseService
  attr_accessor :search_params

  def initialize(search_params)
    @search_params = search_params
  end

  def call
    scope = base_scope
    scope = scope.name_ilike(search_params[:name]) if search_params[:name].present?
    scope = scope.author_ilike(search_params[:author]) if search_params[:author].present?
    scope = scope.ingredients_ilike(search_params[:ingredients]) if search_params[:ingredients].present?
    scope = scope.difficulty_ilike(search_params[:difficulty]) if search_params[:difficulty].present?
    scope = scope.prep_time_at_most(search_params[:prep_time]) if search_params[:prep_time].present?
    scope = scope.cook_time_at_most(search_params[:cook_time]) if search_params[:cook_time].present?
    scope = scope.total_time_at_most(search_params[:total_time]) if search_params[:total_time].present?
    scope = scope.rate_at_least(search_params[:rate]) if search_params[:rate].present?
    scope = scope.with_any_tags(search_params[:tags]) if search_params[:tags].present?
    #byebug
    scope
  end

  private

  def base_scope
    Recipe
  end
end
