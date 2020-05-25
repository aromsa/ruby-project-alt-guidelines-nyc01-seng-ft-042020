class Recipe < ActiveRecord::Base
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :favorite_recipes
    has_many :users, through: :favorite_recipes

    def self.pescatarian 
        Recipe.where(:pescatarian => true)
    end
    
    def self.vegetarian
        Recipe.where(:vegetarian => true)
    end 
    
    def self.gluten_free
        Recipe.where(:gluten_free => true)
    end 

    def self.all_recipes
        Recipe.all
    end

    def self.new_recipe_greet
        puts "Go ahead and type update or create."
        input = gets.chomp
        if input === "create"
            new_recipe
        elsif input === "update"
            update_recipe
        else 
            menu
        end
    end

end

