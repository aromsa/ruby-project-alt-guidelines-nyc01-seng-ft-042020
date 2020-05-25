class User < ActiveRecord::Base
  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes
  has_many :grocery_lists
  has_many :recipe_ingredients, through: :grocery_lists

  def self.user_menu
    cli.greeting 
        input = (gets.chomp).downcase
        case input
        when "sign in"
                cli.sign_in_username_prompt
        when "create profile"
                Member.create_profile
        else
                puts "Please enter a valid option."
      end
  end


  def self.create_profile
    user = User.create(name:name, password: password)
    $user_id = user.id
  end 

end