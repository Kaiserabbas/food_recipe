class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, foreign_key: :recipe_id, dependent: :destroy

  validates :preparationTime, presence: true
  validates :cookTime, presence: true
  validates :description, presence: true, length: { minimum: 250 }
end
