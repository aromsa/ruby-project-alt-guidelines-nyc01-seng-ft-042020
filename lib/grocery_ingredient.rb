class GroceryIngredient < ActiveRecord::Base
  belongs_to :grocery_list 
  belongs_to :recipe_ingredient
end