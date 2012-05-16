require 'open-uri'

class RankinRecipe < ActiveRecord::Base
  attr_accessible :title, :uri, :img_uri
  
  def tp=(value)
    @tp = value
  end
  
  def tp
    @tp
  end

  def save_with_img(outer_uri)
    save_file(outer_uri, self.img_uri) if outer_uri != nil && self.img_uri != nil
    self.save
  end

  private

  def save_file(url, filepath)
    filename = "./public#{filepath}"
    open(filename, 'wb') do |file|
      open(url) do |data|
        file.write(data.read)
      end
    end
  end
end


