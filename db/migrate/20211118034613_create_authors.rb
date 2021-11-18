class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name, index: { unique: true, name: 'unique_authors' }, null: false

      t.timestamps
    end
  end
end
