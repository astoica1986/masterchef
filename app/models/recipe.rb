class Recipe < ApplicationRecord
  include Metka::Model(columns: %w[tags])
  include PgSearch::Model

  validates :name, presence: true, uniqueness: true
  validates :prep_time, numericality: { greater_than_or_equal_to: 0 }
  validates :cook_time, numericality: { greater_than_or_equal_to: 0 }
  validates :total_time, numericality: { greater_than_or_equal_to: 0 }

  scope :prep_time_at_most, ->(value) { where('recipes.prep_time <= ?', value) }
  scope :cook_time_at_most, ->(value) { where('recipes.cook_time <= ?', value) }
  scope :total_time_at_most, ->(value) { where('recipes.total_time <= ?', value) }
  scope :rate_at_least, ->(value) { where('recipes.rate >= ?', value) }
  pg_search_scope :search_recipes,
                  against: { ingredients: 'A', name: 'B', author: 'C', difficulty: 'D'},
                  using: { tsearch: { dictionary: 'french', tsvector_column: 'searchable', any_word: true } }
end
