class ChangeStringColumnsToText < ActiveRecord::Migration[6.1]
  def change
    remove_index :recipes, :name
    %i[name difficulty author].each do |column|
      change_column :recipes, column, :text
      add_index :recipes, column, using: :gin
    end
  end
end
