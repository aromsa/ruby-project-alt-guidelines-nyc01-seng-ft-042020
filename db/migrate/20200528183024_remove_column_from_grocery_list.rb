class RemoveColumnFromGroceryList < ActiveRecord::Migration[5.2]
  def change
    remove_column :grocery_lists, :recipe_ingredient_id, :integer
  end
end
