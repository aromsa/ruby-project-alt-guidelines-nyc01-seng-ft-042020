class User < ActiveRecord::Base
  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes
  has_one :grocery_list
  has_many :grocery_ingredients, through: :grocery_list
  
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
    User.sign_in
  end

  def incorrect_password_characters
    prompt = TTY::Prompt.new
    input = ""
    while input.size < 8
      input = prompt.mask("Please make sure your password is at least 8 characters long.")
    end
    User.last.update(password: input)
    puts "Great!  You are all set #{User.last.name}! Your password has been saved."
    User.sign_in
  end

  def self.sign_in
    prompt = TTY::Prompt.new
    system("clear")
    puts <<-Chef

    .--,--.
    `.  ,.'   
     |___|   
     :o o:    Please sign in to get started!
    _`~^~'_   
  /'   ^   `\

    Chef
    user_name = prompt.ask('Enter your user name:') 
    password = prompt.mask("Enter your case-sensitive password:")
    search = User.find_by(name: user_name.titleize, password: password)
    $user = User.where(id: search).first
    if $user
      system("clear")
      puts ""
      puts ""
      puts "Hi #{user_name.titleize}! You are now signed in."
      puts ""
      puts ""
      sleep(2)
      $user.user_menu_a
      else 
      puts "Incorrect Password."
      sleep(3)
      system("clear")
      CLI.greeting
    end
  end

  def self.add_to_favorites(recipe)
    prompt = TTY::Prompt.new
    puts ""
    puts ""
    input = prompt.select('Would you like to add this recipe to your Favorite Recipes list?', "Yes", "No")
    case input
    when input = "Yes"
      FavoriteRecipe.create(user_id: $user.id, recipe_id: recipe.id)
      puts ""
      puts "Great!  #{recipe.name} has been added to your Favorite Recipes."
      puts ""
      $user.user_menu_b
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
    rcp = Recipe.all.find do |recipe|
      recipe.name == recipe_name
    end
    gl = GroceryList.find_or_create_by(user_id: $user.id)
    RecipeIngredient.all.each do |ri|
      if ri.recipe_id == rcp.id
        GroceryIngredient.create(grocery_list_id: gl.id, recipe_ingredient_id: ri.id)
      end
    end
    puts""
    puts "The ingredients have been added to your grocery list."
    self.user_menu_b
  end

  def update_user_name
    prompt = TTY::Prompt.new
    name = prompt.ask("Hi #{self.name}! Please type your new name/username and hit enter to save.")
    self.name = name
    puts "Okay!  Your new username is #{self.name}."
    self.user_menu_b
  end

  def delete_account
    self.destroy
    puts "Were sad to see you go #{self.name}!"
    CLI.exit_app
  end

  def user_menu_a
    prompt = TTY::Prompt.new
    menu = prompt.select("What would you like to do?", "Browse Recipes", "Update Name/Username", "Delete Reciplease Account", "Exit")
    case menu
    when menu = "Browse Recipes"
      CLI.menu
    when menu = "Update Name/Username"
      self.update_user_name 
    when menu = "Delete Reciplease Account"
      self.delete_account
    when menu = "Exit"
      CLI.exit_app
    end
  end

  def user_menu_b
    prompt = TTY::Prompt.new
    puts ""
    menu = prompt.select("What would you like to do next #{self.name}?", "Browse Recipes", "View Favorites", "View Grocery List", "Main Menu", "Exit")
    case menu
    when menu = "Browse Recipes"
      CLI.menu
    when menu = "View Favorites"
      a = self.recipes.map{|r| r.name}.uniq
      input = prompt.select("Select one of your Favorite Recipes to add the ingredients to your Grocery List:", a)
          self.add_ingredients_to_grocery_list(input)  
    when menu = "View Grocery List"
      self.grocery_list_ingredients
    when menu = "Main Menu"
      self.user_menu_a
    when menu = "Exit"
      CLI.exit_app
    return
  end
end

def grocery_list_ingredients
  a = self.grocery_ingredients.map do |gi|
    gi.recipe_ingredient_id
  end
  b = RecipeIngredient.find(a).map do |ri|
    ri.ingredient_id 
  end
  c = Ingredient.all.find(b).map do |i|
    i.name
  end
  system("clear")
  puts ""
  puts "Grocery List:"
  puts ""
  puts c
  puts ""
  self.user_menu_b
end

end


