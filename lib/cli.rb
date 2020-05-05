require 'pry'
# class CommandLineInterface
# end

def run
    greet
    menu
    input = gets.strip
    if "1"
    pescatarian
    end
end

def greet
    puts 'Hi!! Want to try a new recipe? Select one of the following, using numbers 1 - 5 to get started.'
end

def menu
    puts "
    \u2022 1 \u2022  I am a pescatarian.\n
    \u2022 2 \u2022  I am a vegetarian.\n
    \u2022 3 \u2022  I am gluten free.\n
    \u2022 4 \u2022  I eat everything.\n
    \u2022 5 \u2022  I want a random recipe based on an ingredient.
    "
end
  
def pescatarian 
    Recipe.all.select do |recipes|
        if recipes.pescatarian? == true
        end
    end
end