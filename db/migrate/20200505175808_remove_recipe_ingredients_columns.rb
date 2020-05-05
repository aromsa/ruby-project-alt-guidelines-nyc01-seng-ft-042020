class RemoveRecipeIngredientsColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipe_ingredients, :recipes_id, :integer
    remove_column :recipe_ingredients, :ingredients_id, :integer
  end
end
