require 'open-uri'

class RecipeTitle < ActiveRecord::Base
  attr_accessible :title, :uri

  def self.get_title(uri)
    recipe_title = self.find_by_uri(uri)
    if recipe_title == nil
      recipe_title = self.new
      #URLからタイトル取得
      recipe_title.title = Nokogiri(open(uri).read).title
      #DBに登録
      recipe_title.uri = uri
      recipe_title.save
    end
    return recipe_title
  end
end
