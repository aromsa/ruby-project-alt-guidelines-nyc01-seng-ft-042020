class GroceryList < ActiveRecord::Base
  belongs_to :user 
  belongs_to :recipe_ingredient
end