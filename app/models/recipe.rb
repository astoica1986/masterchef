class Recipe < ApplicationRecord
  belongs_to :author
  include Metka::Model(columns: %w[ingredients tags])

  validates :name, presence: true, uniqueness: true
end
