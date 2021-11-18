class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.float :rate, default: 0.0
      t.string :author_tip
      t.integer :prep_time, default: 0
      t.string :budget
      t.string :name, index: { unique: true, name: 'unique_recipes' }, null: false
      t.string :difficulty
      t.integer :people_quantity
      t.integer :cook_time, default: 0
      t.integer :total_time, default: 0
      t.integer :nb_comments
      t.string :image
      t.text :tags, array: true, default: [], index: { using: :gin }
      t.text :ingredients, array: true, default: [], index: { using: :gin }
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
