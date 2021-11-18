module RecipesHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == @sort_column && @sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, request.query_parameters.merge({ sort_column: column, sort_direction: direction })
  end
end
