class RemoveColumnInGroceryLists < ActiveRecord::Migration[5.2]
  def change
    remove_column :grocery_lists, :recipe_ingredient, :integer
  end
end
