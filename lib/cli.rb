class CLI
    def run
        greet
        menu
    end
    
    def greet
        puts "\nHi!! Want to try a new recipe? Select one of the following, using numbers 1 - 5 to get started.\n 
        \n"
        puts "
        \u2022 1 \u2022  I am a pescatarian.\n
        \u2022 2 \u2022  I am a vegetarian.\n
        \u2022 3 \u2022  I am gluten free.\n
        \u2022 4 \u2022  I eat everything.\n
        \u2022 5 \u2022  I want a random recipe based on an ingredient.
        "
    end
    
    def menu
        input = gets.strip
        case input
        when "1"
            pescatarian
        when "2"
            vegetarian
        when "3"
            gluten_free
        when "4"
            all_recipes
        else "5"
            ingredient_greet
        end
    end

    def vegetarian
        print_recipe_names(Recipe.vegetarian)
    end

    def all_recipes
        print_recipe_names(Recipe.all)
    end

    def gluten_free
        print_recipe_names(Recipe.gluten_free)
    end

    def pescatarian
        print_recipe_names(Recipe.pescatarian)
    end

    def print_recipe_names(recipes)
        recipes.each do |recipe|
            puts recipe.name
        end
    end

    def back_to_menu
        greet
        menu
    end
end

# def run
#     greet
#     menu

# end

# def greet
#     puts "\nHi!! Want to try a new recipe? Select one of the following, using numbers 1 - 5 to get started.\n 
#     \n"
#     puts "
#     \u2022 1 \u2022  I am a pescatarian.\n
#     \u2022 2 \u2022  I am a vegetarian.\n
#     \u2022 3 \u2022  I am gluten free.\n
#     \u2022 4 \u2022  I eat everything.\n
#     \u2022 5 \u2022  I want a random recipe based on an ingredient.
#     "
# end

# def menu
#     input = gets.strip
#     case input
#     when "1"
#         pescatarian
#     when "2"
#         vegetarian
#     when "3"
#         gluten_free
#     when "4"
#         all_recipe_names
#     else "5"
#         ingredient_greet
#     end
# end

# def ingredient_selection
#     input = gets.chomp 
#     included = ingredients.include?(input)
#     if included
#         find_recipe_by_ingredient(input)
#     else 
#         puts "Hmmm, I can't seem to find that ingredient.  Please select an ingredient from the list below."
#         ingredient_greet
#     end
# end

# def ingredients
#     Ingredient.all.map do |ingredient|
#         ingredient.name
#     end
# end

# def ingredient_greet
#     puts "\nHello there!! Type an ingredient from the list below!\n
#     \n"
#     Ingredient.all.each do |ingredient|
#         name = ingredient.name
#         puts "\u2022 #{name} \u2022
#         \n"
#     end
#     ingredient_selection
# end
  
# def pescatarian 
#     recipe_names = []        
#     Recipe.all.select do |recipes|
#         if recipes.pescatarian? == true
#         recipe_names << recipes.name
#         end
#     end
#     puts recipe_names
# end

# def vegetarian
#     recipe_names = []        
#     Recipe.all.select do |recipes|
#         if recipes.vegetarian? == true
#         recipe_names << recipes.name
#         end
#     end
#     puts recipe_names
# end 

# def gluten_free
#     recipe_names = []        
#     Recipe.all.select do |recipes|
#         if recipes.gluten_free? == true
#         recipe_names << recipes.name
#         end
#     end
#     puts recipe_names
# end 

# def all_recipe_names
#     recipe_names = []        
#     Recipe.all.select do |recipes|
#         recipe_names << recipes.name
#     end
#     puts recipe_names
# end 

# def back_to_menu
#     greet
#     menu
# end

# def find_recipe_by_ingredient(i=nil)
#     Ingredient.all.select do |ingredient|
#         if ingredient.name == i
#         puts ingredient.recipes
#         end
#     end
# end



# def recipe_by_diet(diet)
#     diet = 
# end


# def pescatarian 
#     recipe_names = []
#     pesc = Recipe.all.find_by(pescatarian)
#     recipe_names << pesc.name
# end