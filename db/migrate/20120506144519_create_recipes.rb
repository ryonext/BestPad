class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :url
      t.string :tweet_id

      t.timestamps
    end
  end
end
