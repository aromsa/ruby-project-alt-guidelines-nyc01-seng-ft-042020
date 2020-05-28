class RecipeIngredient < ActiveRecord::Base
    belongs_to :recipe 
    belongs_to :ingredient
    has_many :grocery_ingredients
    has_many :grocery_lists, through: :grocery_ingredients
end