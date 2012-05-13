class RecipesController < ApplicationController
  def index
    result = Recipe.count(:id, :group => :url, :order => 'count_id desc', :limit=>10)
    #タイトル追加処理
    @recipes = Array.new
    result.each do |r|
      recipe = Array.new
      recipe.push(r[0])
      recipe.push(r[1])
      recipe.push(RecipeTitle.get_title(r[0]).title)
      @recipes.push(recipe)
    end
    #delayed_jobでデータ取得にいく。
    #Recipe.send_later(:collect)
    #Recipe.delay.method(:collect)
  end

  def update_task
    @result = false
    if params[:token] != ENV['token']
      return
    end
    #更新処理
    Recipe.collect
    @result = true
  end
end
