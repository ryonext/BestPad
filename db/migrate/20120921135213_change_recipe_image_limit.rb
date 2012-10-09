class ChangeRecipeImageLimit < ActiveRecord::Migration
  def up
    change_column :rankin_recipes, :img, :binary, :limit => 700.kilobyte
  end

  def down
  end
end
