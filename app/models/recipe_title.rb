require 'open-uri'

class RecipeTitle < ActiveRecord::Base
  attr_accessible :title, :uri

  def self.get_title(uri)
    recipe_title = self.find_by_uri(uri)
    doc = nil
    if recipe_title == nil
      recipe_title = self.new
      #URLからタイトル取得
      doc = Nokogiri(open(uri).read)
      recipe_title.title = doc.title
      #DBに登録
      recipe_title.uri = uri
      #画像も取得
      recipe_title.save
    end
    if recipe_title.img_url == nil
      if doc == nil
        doc = Nokogiri(open(uri).read)
      end
      img_uri = doc.css("meta")[5].attributes["content"].value
      #画像の取得
      filepath = "/assets/images/recipe/#{recipe_title.id}.jpg"
      self.save_file(img_uri, filepath)
      recipe_title.img_url = filepath
      recipe_title.save
    end
    return recipe_title
  end

  def self.save_file(url, filepath)
    filename = "./public#{filepath}"
    open(filename, 'wb') do |file|
      open(url) do |data|
        file.write(data.read)
      end
    end
  end
end


