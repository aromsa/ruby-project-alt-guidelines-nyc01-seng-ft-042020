class GroceryList < ActiveRecord::Base
  belongs_to :user 
  belongs_to :recipe_ingredient
  has_many :ingredients, through: :recipe_ingredients
end