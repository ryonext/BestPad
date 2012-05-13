#encoding: utf-8
module RecipesHelper
  def format_title(title)
    return title.gsub(" [クックパッド] 簡単おいしいみんなのレシピが121万品", '')
  end
end
