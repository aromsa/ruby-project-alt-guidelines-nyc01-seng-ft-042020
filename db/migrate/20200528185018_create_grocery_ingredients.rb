class CreateGroceryIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery_ingredients do |t|
      t.integer :grocery_list_id
      t.integer :recipe_ingredient_id
    end
  end
end
