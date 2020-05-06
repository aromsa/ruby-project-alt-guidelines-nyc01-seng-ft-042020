class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :directions
      t.boolean :vegetarian
      t.boolean :pescatarian
      t.boolean :gluten_free
    end
  end
end
