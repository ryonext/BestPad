class AddImgToRankinRecipe < ActiveRecord::Migration
  def change
    add_column(:rankin_recipes, :img, :binary)
  end
end
