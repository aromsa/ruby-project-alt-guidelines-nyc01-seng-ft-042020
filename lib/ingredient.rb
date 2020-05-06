class Ingredient < ActiveRecord::Base
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients

    def ingredient_selection
        input = gets.chomp 
        included = ingredients.include?(input)
        if included
            find_recipe_by_ingredient(input)
        else 
            puts "Hmmm, I can't seem to find that ingredient.  Please select an ingredient from the list below."
            ingredient_greet
        end
    end
    
    def ingredients
        Ingredient.all.map do |ingredient|
            ingredient.name
        end
    end
    
    def ingredient_greet
        puts "\nHello there!! Type an ingredient from the list below!\n
        \n"
        Ingredient.all.each do |ingredient|
            name = ingredient.name
            puts "\u2022 #{name} \u2022
            \n"
        end
        ingredient_selection
    end
end