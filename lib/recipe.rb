class Recipe < ActiveRecord::Base
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients

    def self.pescatarian 
        Recipe.where(:pescatarian => true)
        # recipe_names = []        
        # Recipe.all.select do |recipes|
        #     if recipes.pescatarian? == true
        #     recipe_names << recipes.name
        #     end
        # end
        # puts recipe_names
    end
    
    def self.vegetarian
        Recipe.where(:vegetarian => true)
        # recipe_names = []        
        # Recipe.all.select do |recipes|
        #     if recipes.vegetarian? == true
        #     recipe_names << recipes.name
        #     end
        # end
        # puts recipe_names
    end 
    
    def self.gluten_free
        # Recipe.all.select{|r| r.gluten_free?} #=> SELECT * FROM recipes
        Recipe.where(:gluten_free => true) #-> SELECT * FROM recipes WHERE gluten_free = true

        # find_by : detect (Array#find)
        # where : select
    end 
    
    # def self.all
    #     recipe_names = []        
    #     Recipe.all.select do |recipes|
    #         recipe_names << recipes.name
    #     end
    #     puts recipe_names
    # end 


    def find_recipe_by_ingredient(i=nil)
    Ingredient.all.select do |ingredient|
        if ingredient.name == i
        puts ingredient.recipes
        end
    end
end 
end