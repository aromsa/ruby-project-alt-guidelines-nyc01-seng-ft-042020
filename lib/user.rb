class User < ActiveRecord::Base
#If I have time I want a user to sign in and save recipes.  
#To do this I would have to create a new join model for Recipes and Users. 
  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes

end