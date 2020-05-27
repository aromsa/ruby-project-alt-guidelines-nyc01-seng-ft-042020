class User < ActiveRecord::Base
  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes
  has_many :grocery_lists
  has_many :recipe_ingredients, through: :grocery_lists
  
  def self.create_profile
    prompt = TTY::Prompt.new
    input = prompt.ask("Please enter your name/user name:")
    new_user = User.create(name: input.titleize)
    puts "Welcome #{new_user.name}! Please enter your new password."  
    input_b = prompt.mask("* Your password must be at least 8 characters long:")
    if input_b.size < 8
      new_user.incorrect_password_characters
    else
      User.last.update(password: input_b)
      sleep(1)
      puts "Great!  You are all set #{User.last.name}! Your password has been saved."
    end
    system("clear")
    CLI.menu
  end

  def incorrect_password_characters
    prompt = TTY::Prompt.new
    input = ""
    while input.size < 8
      input = prompt.mask("Please make sure your password is at least 8 characters long.")
    end
    User.last.update(password: input)
    puts "Great!  You are all set #{User.last.name}! Your password has been saved."
    CLI.menu
  end

  def self.sign_in
    prompt = TTY::Prompt.new
    user_name = prompt.ask('Please enter your user name:') 
    password = prompt.mask("Please enter your case-sensitive password:")
    search = User.find_by(name: user_name.titleize, password: password)
    $user = User.where(id: search).first
    if $user
      system("clear")
      puts ""
      puts ""
      puts "Welcome back #{user_name.titleize}! You are now signed in."
      puts ""
      puts ""
      sleep(2)
      CLI.menu
      else 
      puts "Incorrect Password."
      sleep(3)
      system("clear")
      CLI.greeting
    end
  end

  def add_to_favorites(recipe)
    prompt = TTY::Prompt.new
    puts ""
    puts ""
    input = prompt.select('Would you like to add this recipe to your Favorite Recipes list?', "Yes", "No")
    case input
    when input = "Yes"
      FavoriteRecipe.create(user_id: self.id, recipe_id: recipe.id)
      puts "Great!  #{recipe.name} has been added to your Favorite Recipes."
      $user.user_menu
    when input = "No"
      puts ""
      CLI.menu
      return
    end
  end

  # def favorite_recipes_ingredients(recipe)
  #   self.recipes.map{|r| r.ingredients}.flatten.uniq
  # end

  def add_ingredients_to_grocery_list(recipe_name)
    #recipe is a recipe ID, and recipe_name is just the recipe name.
    #Have to find a way to fing recipe in RecipeIngredient by recipe name
    search = RecipeIngredient.find_by(recipe: recipe_name)
    recipe = RecipeIngredient.where(id: search).first
    GroceryList.create(user_id: self.id, recipe_ingredient_id: recipe)
    binding.pry

  end

  def user_menu
    #have to create path for BACK TO PREVIOUS MENU
    prompt = TTY::Prompt.new
    menu = prompt.select("What would you like to do next #{self.name}?", "Browse Recipes", "View Favorites", "View Grocery List", "Exit")
    case menu
    when menu = "Browse recipes"
      puts "Browse recipes"
    when menu = "View Favorites"
      a = self.recipes.map{|r| r.name}
      #make multiple selection 
      input = prompt.multi_select("Select one of your Favorite Recipes to add the ingredients to your Grocery List:", a, "Back to previous menu.")
          self.add_ingredients_to_grocery_list(input)
          # binding.pry
    return
    end
  end

end