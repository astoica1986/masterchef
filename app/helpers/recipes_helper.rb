module RecipesHelper
  def sortable(column, title = nil)
    title ||= column.to_s.titleize
    [title, column]
  end

  def sort_column_options
    sort_cols = [sortable(:rank, 'Relevance')]
    [:prep_time, :cook_time, :total_time, :rate].each { |c| sort_cols << sortable(c) }
    sort_cols
  end
end
