class User < ActiveRecord::Base
  has_many :favorite_recipes
  has_many :recipes, through: :favorite_recipes
  has_many :grocery_lists
  has_many :recipe_ingredients, through: :grocery_lists

  def self.create_profile
    puts "Please enter your name! This will serve as your User Name."
    input = gets.chomp.titleize
    new_user = User.create(name: input)
    puts "Welcome #{new_user.name}!  Please enter your new password.\n
    * Your password must be at least 8 characters long.\n"
    input_b = gets.chomp
    if input_b.size < 8
      puts "Please make sure your password is at least 8 characters long."
      new_user.incorrect_password
    else
      #having trouble saving the password
      new_user.password = "#{input_b}"
      puts "Great!  You are all set!"
    end
    menu
  end

  def incorrect_password
    loop do
    input = gets.chomp
      if input.size < 8
      puts "Please make sure your password is at least 8 characters long."
      else input.size >= 8
        User.last.password = "#{input}"
        puts "Great!  You are all set!"
      end
    end
  end





  # def self.user_menu
  #   cli.greeting 
  #       input = (gets.chomp).downcase
  #       case input
  #       when "sign in"
  #               cli.sign_in_username_prompt
  #       when "create profile"
  #               Member.create_profile
  #       else
  #               puts "Please enter a valid option."
  #     end
  # end


  # def self.create_profile
  #   user = User.create(name:name, password: password)
  #   $user_id = user.id
  # end 

end