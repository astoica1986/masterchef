class ChangeIngredientsToText < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'btree_gin'
    remove_index :recipes, :ingredients
    change_column :recipes, :ingredients, :text
    add_index :recipes, :ingredients, using: :gin
  end
end
