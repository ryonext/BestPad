class CreateRecipeTitles < ActiveRecord::Migration
  def change
    create_table :recipe_titles do |t|
      t.string :uri
      t.string :title

      t.timestamps
    end
  end
end
