class RecipesController < ApplicationController
  def index
    @recipes = Recipe.count(:id, :group => :url, :order => 'count_id desc', :limit=>10)
  end
end
