json.extract! recipe, :id, :rate, :author_tip, :prep_time, :budget, :name, :difficulty, :people_quantity, :cook_time, :total_time, :nb_comments, :image, :tags, :ingredients, :author_id, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
