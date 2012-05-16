class RenameRecipeTitleToRankinRecipe < ActiveRecord::Migration
  def up
    rename_table('recipe_titles', 'rankin_recipes')
  end

  def down
    rename_table('rankin_recipes', 'recipe_titles')
  end
end
