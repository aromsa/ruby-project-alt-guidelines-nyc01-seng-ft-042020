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
    @user = prompt.ask('Please enter your user name:') 
    password = prompt.mask("Please enter your case-sensitive password:")
    search = User.find_by(name: @user.titleize, password: password)
    finduser = User.where(id: search).first
    if finduser
      puts ""
      puts ""
      sleep(1)
      puts "Welcome back #{@user.titleize}! You are now signed in."
      puts ""
      puts ""
      sleep(2)
      CLI.menu
      else 
      puts "Incorrect Password."
      CLI.greeting
    end
  end
end