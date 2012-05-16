require 'open-uri'

class RankinRecipe < ActiveRecord::Base
  attr_accessible :title, :uri, :img_uri
  
  def tp=(value)
    @tp = value
  end
  
  def tp
    @tp
  end

#  def set_title_and_img(uri)
#    doc = Nokogiri(open(uri).read)
#    @title = doc.title
#    img_tag = doc.css("meta")[5]
#    if img_tag != nil
#      #画像の取得
#      @outer_img_uri  = img_tag.attributes["content"].value
#      @img_uri = "/assets/images/recipe/#{Time.now}.jpg"
#    end
#    p @img_uri
#  end
#
#  def self.get_title(uri)
#    recipe_title = self.find_by_uri(uri)
#    doc = nil
#    if recipe_title == nil
#      recipe_title = self.new
#      #URLからタイトル取得
#      recipe_title.title = doc.title
#      #DBに登録
#      recipe_title.uri = uri
#      #画像も取得
#      recipe_title.save
#    end
#    if recipe_title.img_url == nil
#      doc = Nokogiri(open(uri).read) if doc == nil
#      img_tag = doc.css("meta")[5]
#      return recipe_title if img_tag == nil
#      img_uri = img_tag.attributes["content"].value
#      #画像の取得
#      filepath = "/assets/images/recipe/#{recipe_title.id}.jpg"
#      self.save_file(img_uri, filepath)
#      recipe_title.img_url = filepath
#      recipe_title.save
#    end
#    return recipe_title
#  end
#
#  def self.save_file(url, filepath)
#    filename = "./public#{filepath}"
#    open(filename, 'wb') do |file|
#      open(url) do |data|
#        file.write(data.read)
#      end
#    end
#  end
end


