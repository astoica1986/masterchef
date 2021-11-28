class AddSearchableColumnToRecipes < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      ALTER TABLE recipes
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('french', coalesce(ingredients, '')), 'A') ||
        setweight(to_tsvector('french', coalesce(name,'')), 'B') ||
        setweight(to_tsvector('french', coalesce(author,'')), 'C') ||
        setweight(to_tsvector('french', coalesce(difficulty,'')), 'D')
      ) STORED;
    SQL
  end

  def down
    remove_column :recipes, :searchable
  end
end
