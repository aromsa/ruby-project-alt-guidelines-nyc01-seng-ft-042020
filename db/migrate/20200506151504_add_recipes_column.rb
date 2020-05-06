class AddRecipesColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :vegetarian?, :boolean
  end
end
