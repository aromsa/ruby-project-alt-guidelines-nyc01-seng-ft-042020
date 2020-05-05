# Five to ten instances of each model, as well as the corresponding 
# relationships should be enough. You can always add more later.


User.delete_all
Recipe.delete_all
Ingredient.delete_all
RecipeIngredient.delete_all

User.create(name: Faker::Name.name)

Recipe.create(name: "Grilled Salmon with Asparagus", directions: "Grill salmon and asparugus at medium heat until salmon reaches 145 degrees fahrenheit (usually about 12 min.)", vegeterian?: false, pescatarian?: true, gluten_free?: true)
Recipe.create(name: "BBQ Chicked & Sweet Potato Fries", directions: "Marinate 2 chicken breast in 1/4 cup of BBQ sauce for 2 hours.  Meanwhile, chop sweet potatoes into uniform fry size.   Place sweet potatoes on a baking sheet and bake at 425 for 30 min.  Grill chicken breast at medium heat until internal temp reaches 165 degrees farenheit.", vegeterian?: false, pescatarian?: false, gluten_free?: true)
Recipe.create(name: "Oatmeal", directions: "test", vegeterian?: true, pescatarian?: true, gluten_free?: true)
Recipe.create(name: "Griled Cheese", directions: "test", vegeterian?: true, pescatarian?: true, gluten_free?: false)

i1 = Ingredient.create(name: "salmon")
i2 = Ingredient.create(name: "asparagus")
i3 = Ingredient.create(name: "BBQ sauce")
i4 = Ingredient.create(name: "chicken breast")
i5 = Ingredient.create(name: "sweet potato")
i6 = Ingredient.create(name: "oatmenal")
i7 = Ingredient.create(name: "bread")
i8 = Ingredient.create(name: "cheese")

RecipeIngredient.create(recipe: Recipe.first, ingredient: i1)
RecipeIngredient.create(recipe: Recipe.first, ingredient: i2)

RecipeIngredient.create(recipe: Recipe.second, ingredient: i3)
RecipeIngredient.create(recipe: Recipe.second, ingredient: i4)
RecipeIngredient.create(recipe: Recipe.second, ingredient: i5)

RecipeIngredient.create(recipe: Recipe.third, ingredient: i6)

RecipeIngredient.create(recipe: Recipe.fourth, ingredient: i7)
RecipeIngredient.create(recipe: Recipe.fourth, ingredient: i8)








