class Recipe < ApplicationRecord
  include Metka::Model(columns: %w[ingredients tags])
  validates :name, presence: true, uniqueness: true
  validates :prep_time, numericality: { greater_than_or_equal_to: 0 }
  validates :cook_time, numericality: { greater_than_or_equal_to: 0 }
  validates :total_time, numericality: { greater_than_or_equal_to: 0 }

  scope :name_ilike, ->(value) { where('recipes.name ilike ?', "%#{value}%") }
  scope :ingredients_ilike, ->(value) { where('recipes.ingredients ilike ?', "%#{value}%") }
  scope :difficulty_ilike, ->(value) { where('recipes.difficulty ilike ?', "%#{value}%") }
  scope :author_ilike, ->(value) { where('recipes.name ilike ?', "%#{value}%") }
  scope :prep_time_at_most, ->(value) { where('recipes.prep_time <= ?', value) }
  scope :cook_time_at_most, ->(value) { where('recipes.cook_time <= ?', value) }
  scope :total_time_at_most, ->(value) { where('recipes.total_time <= ?', value) }
  scope :rate_at_least, ->(value) { where('recipes.rate >= ?', value) }
end
