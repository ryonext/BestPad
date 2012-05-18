class RemoveImgFromRankinRecipe < ActiveRecord::Migration
  def up
    remove_column(:rankin_recipes, :img_uri)
  end

  def down
    add_column(:rankin_recipes, :img_uri, :string)
  end
end
