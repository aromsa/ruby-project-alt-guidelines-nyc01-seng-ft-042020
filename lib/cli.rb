class CLI
    # def run
    #     menu
    # end

    def self.greeting 
        puts <<-Greeting                                        
 
    ________________________________________________________
    / \                                                       \.
    |   |                                                      |.
    \_ ..|               Welcome to ReciPlease!                 |.
        |        Please sign in or create a new profile.       |.
        |                                                      |.
        |______________________________________________________|
        |                           +                          |.
        |          Sign In          +      Create Profile      |.
        |                           +                          |.
        |___________________________+__________________________|. 
        |                                                      |.
        |                                                      |.
        |                                                      |.
        |                                                      |.
        |   ___________________________________________________|____
        |  /                                                     /.
        \_/_____________________________________________________/.

    Greeting
    end

    def self.sign_in_username_prompt
        puts "                 Please enter your username."
    end
   
end

    def menu
        # require "tty-prompt"
        # prompt = TTY::Prompt.new
        # first_menu = prompt.select("What would you like to do first", "Find a new Anime", "Edit my lists", "End")
        puts "\nHi!! Want to try a new recipe? Select one of the following, using numbers 1 - 6 to get started.\n 
        \n"
        puts "
        \u2022 1 \u2022  I am a pescatarian.\n
        \u2022 2 \u2022  I am a vegetarian.\n
        \u2022 3 \u2022  I am gluten free.\n
        \u2022 4 \u2022  I eat everything.\n
        \u2022 5 \u2022  I want a random recipe based on an ingredient.\n
        \u2022 6 \u2022  I want to create or update a recipe.
        "
        list
    end
    
    def list
        input = gets.strip
        case input
        when "1"
            print_recipe_names(Recipe.pescatarian)
            menu
        when "2"
            print_recipe_names(Recipe.vegetarian)
            menu
        when "3"
            print_recipe_names(Recipe.gluten_free)
            menu
        when "4"
            print_recipe_names(Recipe.all_recipes)
            menu
        when "5"
            ingredient_greet
        when "6"
            Recipe.new_recipe_greet
        else "menu"
            menu
        end
    end

    def print_recipe_names(recipes)
        recipes.each do |recipe|
            puts recipe.name
        end
    end

    def new_recipe
        puts "Ooh a new recipe!!  To get started, enter the name of your recipe."
        input_a = gets.chomp
        recipe = Recipe.create(name: input_a)
        puts "Yeerm!!  Now type out the directions."
        input_b = gets.chomp
        recipe.directions = input_b
        puts "Great!  Would you like to save your recipe or delete it?  Type save or delete below."
        input_c = gets.chomp
            if input_c === "save"
                recipe.save
                puts "Your recipe titled #{input_a} has been saved!"
                puts "Would you like to add ingredients? y/n"
                input_d = gets.strip.downcase
                if input_d == "y"
                    puts "Great, enter ingredients in a comma seperated list:"
                    input_e = gets.strip.downcase
                    
                    ingriedient_names = input_e.split(",").collect{|w| w.strip.downcase}
                    ingriedient_names.each do |ingredient_name|
                        ingredient = Ingredient.find_or_create_by(:name => ingredient_name)
                        recipe.ingredients << ingredient
                        # times {BEGIN {puts "Your ingredients have been added to #{input_a}."}}
                        #trying to figure out a way to only puts this once rather than
                        #for every ingredient.
                    end
                end
            elsif input_c === "delete"
                delete_recipe
                puts "Your recipe titled #{input_a} has been deleted."
            end
        menu
    end
    
    def update_recipe
        puts "Updates!!  I love updates!  Select from following recipes by typing it below."
        print_recipe_names(Recipe.all)

        input = gets.chomp
        recipe = Recipe.find_by(:name => input)
        if recipe
            puts "Okay, lets update the recipe named #{recipe.name}.  Type the new name below."
            new_name = gets.strip
            recipe.update(:name => new_name)
            puts "Your recipe is now called #{new_name}!"
            menu
        else 
            puts "Hmmm, I can't seem to find that recipe.  Please select a recipe from the list."
        end
    end


    def ingredient_greet
        puts "\nHello there!! Type an ingredient from the list below!\n
        \n"
        Ingredient.all.each do |ingredient|
            puts "\u2022 #{ingredient.name} \u2022
            \n"
        end
        ingredient_selection
    end

    def ingredient_selection
        input = gets.chomp 
        included = ingredients.include?(input)
        if included
            find_recipe_by_ingredient(input)
            menu
        elsif 
            puts "Hmmm, I can't seem to find that ingredient.  Please select an ingredient from the list."
            ingredient_greet
        else
            menu
        end
    end
    
    def find_recipe_by_ingredient(i=nil)
        Ingredient.all.select do |ingredient|
            if ingredient.name == i
                ingredient.recipes.each do |recipe|
                    puts recipe.name
                    #I want to add directions and ingredient here too. 
                end
            end
        end
    end 

    def back_to_menu
        greet
        menu
    end
    
    def ingredients
        Ingredient.all.map do |ingredient|
            ingredient.name
        end
    end

    def delete_recipe
        recipe = Recipe.last
        recipe.delete
    end

