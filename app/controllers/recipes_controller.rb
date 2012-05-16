class RecipesController < ApplicationController
  def index
    result = Recipe.count(:id, :group => :url, :order => 'count_id desc', :limit => 10)
    @r_recipes = Array.new
    result.each do |r|
      uri = r[0]
      r_recipe = RankinRecipe.find_by_uri(uri) || RankinRecipe.new
      if r_recipe.title == nil || r_recipe.img_uri == nil
        doc = Nokogiri(open(uri).read)
        r_recipe.uri = uri
        r_recipe.title = doc.title
        img_tag = doc.css("meta")[5]
        if img_tag != nil
          outer_img_uri  = img_tag.attributes["content"].value
          cookpad_id = uri.split('/')[4]
          r_recipe.img_uri = "/assets/images/recipe/#{cookpad_id}.jpg"
        end
        r_recipe.save
        #r_recipe.save_with_img(outer_img_uri)
      end
      r_recipe.tp = r[1]
      @r_recipes.push(r_recipe)
    end
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
      logger.error "authenticate error:#{params[:token]}:#{ENV['token']} does not much"
      return render :template => 'recipes/update_task'
    end
    Recipe.where('created_at < ?', 1.day.ago).delete_all
    @result = true
    return render :template => 'recipes/update_task'
  end
end
