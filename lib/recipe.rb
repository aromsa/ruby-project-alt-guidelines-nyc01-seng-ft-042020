require 'pry'
class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :favorite_recipes
  has_many :users, through: :favorite_recipes

  def self.pescatarian 
    #have to add path for BACK TO PREVIOUS MENU
    prompt = TTY::Prompt.new
    recipes = Recipe.where(:pescatarian => true)
    a = recipes.map do |r| 
      r.name
    end
    input = prompt.select("Select one of the following to see the directions and ingredients.", a, "Back to previous menu.")  
    Recipe.find_recipe_by_recipe_name(input)
  end

  def self.vegetarian
    #""
    prompt = TTY::Prompt.new
    recipes = Recipe.where(:vegetarian => true)
    a = recipes.map do |r| 
      r.name
    end
    input = prompt.select("Select one of the following to add to your Favorite Recipe list.", a, "Back to previous menu.")  
    included = a.include?(input)
      if included
        Recipe.find_recipe_by_recipe_name(input)
    end
  end 
    
  def self.gluten_free
    #""
    prompt = TTY::Prompt.new
    recipes = Recipe.where(:gluten_free => true)
    a = recipes.map do |r| 
      r.name
    end
    menu = prompt.select("Select one of the following to add to your Favorite Recipe list.", a, "Back to previous menu.")
  end 

  def self.all_recipes
    #""
    prompt = TTY::Prompt.new
    recipes = Recipe.all
    a = recipes.map do |r| 
      r.name
    end
    menu = prompt.select("Select one of the following to add to your Favorite Recipe list.", a, "Back to previous menu.")
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

  def self.find_recipe_by_recipe_name(i=nil)
    Recipe.all.select do |recipe|
      if recipe.name == i
        system("clear")
        puts ""
        puts ""
        puts recipe.name
        puts ""
        puts ""
        sleep(1)
        puts "Directions: #{recipe.directions}"
        puts ""
        puts ""
        sleep(1)
        a = Recipe.ingredient_names(recipe.ingredients)
          puts "Ingredients:"
          puts ""
          "#{a.each{|a| puts a}}"
      end
      $user.add_to_favorites(recipe)
    end
  end

  def self.ingredient_names(ingredients)
    ingredients.map{|i| i.name}
  end

end



  # def self.print_recipe_names(recipes)
  #   recipes.map do |recipe|
  #     recipe.name
  #   end
  # end