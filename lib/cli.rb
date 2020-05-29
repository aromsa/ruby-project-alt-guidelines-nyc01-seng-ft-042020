class CLI

  def self.greeting
    system("clear")
    puts <<-'EOF'


             ____           _ ____  _                     
            |  _ \ ___  ___(_)  _ \| | ___  __ _ ___  ___ 
            | |_) / _ \/ __| | |_) | |/ _ \/ _` / __|/ _ \
            |  _ <  __/ (__| |  __/| |  __/ (_| \__ \  __/
            |_| \_\___|\___|_|_|   |_|\___|\__,_|___/\___|

    EOF
    puts <<-Greeting     
   ________________________________________________________
    / \                                                       \.
    |   |                                                      |.
    \_ ..|               Welcome to ReciPlease!                 |.
        |        Please sign in or create a new profile.       |.
        |                                                      |.
        |______________________________________________________|
        |                +                     +               |.
        |     Sign In    +    Create Profile   +      Exit     |.
        |                +                     +               |.
        |________________+_____________________+_______________|. 
        |                                                      |.
        |                                                      |.
        |                                                      |.
        |                                                      |.
        |   ___________________________________________________|____
        |  /                                                     /.
        \_/_____________________________________________________/.

    Greeting
    CLI.menu_b
  end

  def self.menu_b
    prompt = TTY::Prompt.new
    menu = prompt.select("Select:", "Sign In", "Create Profile", "Exit")
    case menu
    when menu = "Sign In"
      User.sign_in
    when menu = "Create Profile"
      User.create_profile
    when menu = "Exit"
      CLI.exit_app
    end
  end

  def self.exit_app
    system("clear")
    puts <<-Goodbye                                        
    ________________________________________________________
    / \                                                       \.
    |   |                                                      |.
    \_ ..|                                                      |.
        |                       Goodbye!                       |.
        |            Thank you for using ReciPlease!           |.
        |                                                      |.
        |                                                      |.
        |                                                      |.
        |                                                      |.
        |   ___________________________________________________|___
        |  /                                                     /.
        \_/_____________________________________________________/.

    Goodbye
    exit(true)
  end

  def self.menu
    prompt = TTY::Prompt.new
    menu = prompt.select("Want to try a new recipe? Select one of the following (scroll down to Exit):", "I am a pescatarian.", "I am a vegetarian.", "I am gluten free.", "I eat everything.","I want a random recipe based on an ingredient.", "I want to create or update a recipe.", "Exit")
    case menu
    when menu = "I am a pescatarian."
      Recipe.pescatarian
    when menu = "I am a vegetarian."
      Recipe.vegetarian
    when menu = "I am gluten free."
      Recipe.gluten_free
    when menu = "I eat everything."
      Recipe.all_recipes
    when menu = "I want a random recipe based on an ingredient."
      ingredient_greet
    when menu = "I want to create or update a recipe."
      Recipe.new_recipe_greet
    when menu = "Exit"
      CLI.exit_app
    end
  end

end   


def ingredient_greet
  prompt = TTY::Prompt.new
  a = Ingredient.all.map do |ingredient|
    ingredient.name
  end
  input = prompt.select("Select an ingredient (keep scrolling down for more):", a)
  find_recipe_by_ingredient(input)
end
    
def find_recipe_by_ingredient(i=nil)
  prompt = TTY::Prompt.new
  Ingredient.all.select do |ingredient|
    if ingredient.name == i
      r = ingredient.recipes.find do |recipe|
        recipe.name
      end
      Recipe.find_recipe_by_recipe_name(r.name)
    end
  end
end 

def ingredients
  Ingredient.all.map do |ingredient|
    ingredient.name
  end
end
