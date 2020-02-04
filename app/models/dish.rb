class Dish < ApplicationRecord
  belongs_to :recipe, optional: true
  belongs_to :restaurant, optional: true

  has_many :dish_diets
  has_many :diets, through: :dish_diets

  has_many :dish_cuisines
  has_many :cuisines, through: :dish_cuisines

  has_many :dish_courses
  has_many :courses, through: :dish_courses

  has_many :favorites
  has_many :users, through: :favorites

  def getDiets
    self.diets.map do |diet|
      diet.name
    end
  end

end
