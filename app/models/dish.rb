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

  def get_diets
    self.diets.map do |diet|
      diet.name
    end
  end

  def get_cuisines
    self.cuisines.map do |cuisine|
      cuisine.name
    end
  end

  def get_courses
    self.courses.map do |course|
      course.name
    end
  end

end
