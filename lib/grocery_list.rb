class GroceryList < ActiveRecord::Base
  belongs_to :user 
  has_many :grocery_ingredients
  has_many :recipe_ingredients, through: :grocery_ingredients
end