class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :directions
      t.boolean :vegeterian?
      t.boolean :pescatarian?
      t.boolean :gluten_free?
    end
  end
end
