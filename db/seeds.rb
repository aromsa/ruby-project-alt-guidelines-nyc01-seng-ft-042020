# Five to ten instances of each model, as well as the corresponding 
# relationships should be enough. You can always add more later.


User.delete_all
Recipe.delete_all
Ingredient.delete_all
RecipeIngredient.delete_all
FavoriteRecipe.delete_all
GroceryList.delete_all
GroceryIngredient.delete_all

u1 = User.create(name: Faker::Name.name)
u2 = User.create(name: Faker::Name.name)
u3 = User.create(name: Faker::Name.name)
u4 = User.create(name: Faker::Name.name)
u5 = User.create(name: "Anna", password: "Ilovecoding")

r1 = Recipe.create(name: "Grilled Salmon with Asparagus", directions: "Grill salmon and asparugus at medium heat until salmon reaches 145 degrees fahrenheit (usually about 12 min.)", vegetarian: false, pescatarian: true, gluten_free: true)
r2 = Recipe.create(name: "BBQ Chicked & Sweet Potato Fries", directions: "Marinate 2 chicken breast in 1/4 cup of BBQ sauce for 2 hours.  Meanwhile, chop sweet potatoes into uniform fry size.   Place sweet potatoes on a baking sheet and bake at 425 for 30 min.  Grill chicken breast at medium heat until internal temp reaches 165 degrees farenheit.", vegetarian: false, pescatarian: false, gluten_free: true)
r3 = Recipe.create(name: "Oatmeal", directions: "test", vegetarian: true, pescatarian: true, gluten_free: true)
r4 = Recipe.create(name: "Grilled Cheese", directions: "test", vegetarian: true, pescatarian: true, gluten_free: false)
r5 = Recipe.create(name: "Scrambled Eggs", directions: "test", vegetarian: true, pescatarian: true, gluten_free: true)

salmon = Ingredient.create(name: "salmon")
asparagus = Ingredient.create(name: "asparagus")
i3 = Ingredient.create(name: "BBQ sauce")
i4 = Ingredient.create(name: "chicken breast")
i5 = Ingredient.create(name: "sweet potato")
i6 = Ingredient.create(name: "oatmeal")
i7 = Ingredient.create(name: "bread")
i8 = Ingredient.create(name: "cheese")
i9 = Ingredient.create(name: "egg")

RecipeIngredient.create(recipe: Recipe.first, ingredient: salmon)
RecipeIngredient.create(recipe: Recipe.first, ingredient: asparagus)
RecipeIngredient.create(recipe: Recipe.second, ingredient: i3)
RecipeIngredient.create(recipe: Recipe.second, ingredient: i4)
RecipeIngredient.create(recipe: Recipe.second, ingredient: i5)
RecipeIngredient.create(recipe: Recipe.third, ingredient: i6)
RecipeIngredient.create(recipe: Recipe.fourth, ingredient: i7)
RecipeIngredient.create(recipe: Recipe.fourth, ingredient: i8)

f1 = FavoriteRecipe.create(user: u1, recipe:r1)
f2 = FavoriteRecipe.create(user: u2, recipe:r3)
f3 = FavoriteRecipe.create(user: u2, recipe:r5)
f4 = FavoriteRecipe.create(user: u4, recipe:r5)
f5 = FavoriteRecipe.create(user: u5, recipe:r2)









