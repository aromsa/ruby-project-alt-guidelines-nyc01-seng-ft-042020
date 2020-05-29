require 'pry'
class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :favorite_recipes
  has_many :users, through: :favorite_recipes

  def self.pescatarian 
    #this only works on Grilled Salmon
    #need to code a path back to previous menu
    prompt = TTY::Prompt.new
    recipes = Recipe.where(:pescatarian => true)
    a = recipes.map do |r| 
      r.name
    end
    input = prompt.select("Select one of the following to see the directions and ingredients.", a)  
    Recipe.find_recipe_by_recipe_name(input)
  end

  def self.vegetarian
    prompt = TTY::Prompt.new
    recipes = Recipe.where(:vegetarian => true)
    a = recipes.map do |r| 
      r.name
    end
    input = prompt.select("Select one of the following to see the directions and ingredients.", a)  
    Recipe.find_recipe_by_recipe_name(input)
  end 
    
  def self.gluten_free
    prompt = TTY::Prompt.new
    recipes = Recipe.where(:gluten_free => true)
    a = recipes.map do |r| 
      r.name
    end
    input = prompt.select("Select one of the following to see the directions and ingredients.", a)  
    Recipe.find_recipe_by_recipe_name(input)
  end

  def self.all_recipes
    prompt = TTY::Prompt.new
    recipes = Recipe.all
    a = recipes.map do |r| 
      r.name
    end
    input = prompt.select("Select one of the following to see the directions and ingredients.", a)  
    Recipe.find_recipe_by_recipe_name(input)
  end

  def self.new_recipe_greet
    system("clear")
    prompt = TTY::Prompt.new
    input = prompt.select("Please select update or create.", "Update", "Create")
    case input
    when input = "Update"
      Recipe.update_recipe
    when input = "Create"
      Recipe.new_recipe
    end
  end

  def self.find_recipe_by_recipe_name(i)
    rcp = Recipe.all.find do |recipe|
      recipe.name == i
    end
      # case rcp
      # when rcp
      system("clear")
      puts ""
      puts ""
      puts rcp.name
      puts ""
      puts ""
      sleep(1)
      puts "Directions: #{rcp.directions}"
      puts ""
      puts ""
      sleep(1)
      a = Recipe.ingredient_names(rcp.ingredients)
      puts "Ingredients:"
      puts ""
      "#{a.each{|a| puts a}}"
    # end
    User.add_to_favorites(rcp)
  # end 
  end

  def self.ingredient_names(ingredients)
    ingredients.map{|i| i.name}
  end

  def self.new_recipe
    prompt = TTY::Prompt.new
    puts "Ooh a new recipe!!  To get started, enter the name of your recipe."
    input_a = gets.chomp
    recipe = Recipe.create(name: input_a)
    puts ""
    puts "Yeerm!!  Now type out the directions."
    input_b = gets.chomp
    recipe.directions = input_b
    puts ""
    input_c = prompt.select("Great!  Plese select save to save your recipe, or delete to start over.", "Save", "Delete")
    # puts "Great!  Would you like to save your recipe or delete it?  Type save or delete below."
    # input_c = gets.chomp
    case input_c
    when input_c = "Save"
        recipe.save
            puts ""
            puts "Your recipe titled #{input_a} has been saved!"
            input_d = prompt.select("Would you like to add ingredients?", "Yes", "No")
            # puts "Would you like to add ingredients? y/n"
            # input_d = gets.strip.downcase
            case input_d
            when input_d = "Yes"
            # if input_d == "y"
                puts "Great, enter ingredients in a comma seperated list:"
                input_e = gets.strip.downcase
                ingriedient_names = input_e.split(",").collect{|w| w.strip.downcase}
                ingriedient_names.each do |ingredient_name|
                    ingredient = Ingredient.find_or_create_by(:name => ingredient_name)
                    recipe.ingredients << ingredient
                    # puts "Your ingredients have been added to #{input_a}."
                    # 1.times {BEGIN {puts "Your ingredients have been added to #{input_a}."}}
                    #trying to figure out a way to only puts this once rather than
                    #for every ingredient.
                end
                puts "Your ingredients have been added to #{input_a}."
            end
         when input_c = "Delete"
            Recipe.delete_recipe
            puts "Your recipe titled #{input_a} has been deleted."
        end
    $user.user_menu_a
end

def self.delete_recipe
  recipe = Recipe.last
  recipe.delete
end

def self.update_recipe
  prompt = TTY::Prompt.new
  recipes = Recipe.all
    a = recipes.map do |r| 
      r.name
    end
  input = prompt.select("Updates!!  I love updates!  Select from following recipes", a) 
  # puts "Updates!!  I love updates!  Select from following recipes by typing it below."
  # print_recipe_names(Recipe.all)

  # input = gets.chomp
  recipe = Recipe.find_by(:name => input)
  # if recipe
      puts "Okay, lets update the recipe named #{recipe.name}.  Type the new name below."
      new_name = gets.strip
      recipe.update(:name => new_name)
      puts "Your recipe is now called #{new_name}!"
      $user.user_menu_a
  # else 
  #     puts "Hmmm, I can't seem to find that recipe.  Please select a recipe from the list."
  # $user.user_menu_a
end

end



  # def self.print_recipe_names(recipes)
  #   recipes.map do |recipe|
  #     recipe.name
  #   end
  # end