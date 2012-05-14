class RecipesController < ApplicationController
  def index
    result = Recipe.count(:id, :group => :url, :order => 'count_id desc', :limit=>10)
    #タイトル追加処理
    @recipes = Array.new
    result.each do |r|
      recipe = Array.new
      recipe.push(r[0])
      recipe.push(r[1])
      recipe_title = RecipeTitle.get_title(r[0])
      recipe.push(recipe_title.title)
      recipe.push(recipe_title.img_url)
      @recipes.push(recipe)
    end
    #delayed_jobでデータ取得にいく。
    #Recipe.send_later(:collect)
    #Recipe.delay.method(:collect)
  end

  def update_task
    @result = false
    if params[:token] != ENV['token']
      logger.error "authenticate error:#{params[:token]}:#{ENV['token']} does not much"
      return
    end
    #更新処理
    Recipe.collect(10, 100, 10)
    @result = true
  end

  def delete_task
    @result = false
    if params[:token] != ENV['token']
      p params[:token]
      p ENV['token']
      logger.error "authenticate error:#{params[:token]}:#{ENV['token']} does not much"
      return render :template => 'recipes/update_task'
    end
    Recipe.where('created_at < ?', 1.day.ago).delete_all
    @result = true
    return render :template => 'recipes/update_task'
  end
end
