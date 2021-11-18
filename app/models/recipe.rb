class Recipe < ApplicationRecord
  include Metka::Model(columns: %w[ingredients tags])

  validates :name, presence: true, uniqueness: true
end
