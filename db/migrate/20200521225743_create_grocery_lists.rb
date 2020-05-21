class CreateGroceryLists < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery_lists do |t|
      t.integer :user_id
      t.integer :recipe_ingredient
    end
  end
end
