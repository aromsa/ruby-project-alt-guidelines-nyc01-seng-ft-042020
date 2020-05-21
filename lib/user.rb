class User < ActiveRecord::Base
  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes
  has_many :grocery_lists
  has_many :recipe_ingredients, through: :grocery_lists
end