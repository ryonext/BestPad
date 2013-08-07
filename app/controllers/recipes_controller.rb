class RecipesController < ApplicationController
  def index
    result = Recipe.count(:id, :group => :url, :order => 'count_id desc', :limit => 10)
    @r_recipes = Array.new
    result.each do |r|
      uri = r[0]
      r_recipe = RankinRecipe.find_by_uri(uri) || RankinRecipe.new
      if r_recipe.title == nil || r_recipe.img == nil
        doc = Nokogiri(open(uri).read)
        r_recipe.uri = uri
        r_recipe.title = doc.title
        img_tag = doc.css("meta[property='og:image']").first
        if img_tag != nil
          outer_img_uri  = img_tag.attributes["content"].value
          begin
            r_recipe.img = open(outer_img_uri).read if outer_img_uri != nil
          rescue
          end
        end
        r_recipe.save
      end
      r_recipe.tp = r[1]
      @r_recipes.push(r_recipe)
    end
  end

  def image
    r_recipe = RankinRecipe.find(params[:id])
    send_data r_recipe.img, :type => "image/jpeg", :disposition => "inline" if r_recipe.img != nil
  end

  def stage_index
    self.index
  end

  def update_task
    @result = false
    if params[:token] != ENV['token']
      logger.error "authenticate error:#{params[:token]}:#{ENV['token']} does not much"
      return head 400
    end
    #更新処理
    Recipe.collect(10, 100, 10)
    @result = true
    return head :created
  end

  def delete_task
    @result = false
    if params[:token] != ENV['token']
      logger.error "authenticate error:#{params[:token]}:#{ENV['token']} does not much"
      return head 400
    end
    Recipe.where('created_at < ?', 1.day.ago).delete_all
    RankinRecipe.where('created_at < ?', 2.day.ago).delete_all
    @result = true
    return render :template => 'recipes/update_task', :status => :no_content
  end
end
