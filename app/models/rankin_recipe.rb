require 'open-uri'

class RankinRecipe < ActiveRecord::Base
  attr_accessible :title, :uri,:img
  
  def tp=(value)
    @tp = value
  end
  
  def tp
    @tp
  end

end


