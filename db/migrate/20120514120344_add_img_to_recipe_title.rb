class AddImgToRecipeTitle < ActiveRecord::Migration
  def change
    add_column :recipe_titles, :img_url, :string
  end
end
