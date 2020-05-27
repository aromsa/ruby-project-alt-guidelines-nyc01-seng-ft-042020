class AddColumnToGroceryList < ActiveRecord::Migration[5.2]
  def change
    add_column :grocery_lists, :recipe_ingredient_id, :integer
  end
end
