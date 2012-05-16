class RenameColumnRankinRecipes < ActiveRecord::Migration
  def up
    rename_column(:rankin_recipes, :img_url, :img_uri)
  end

  def down
    rename_column(:rankin_recipes, :img_uri, :img_url)
  end
end
