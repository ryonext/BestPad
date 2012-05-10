require 'open-uri'
require 'net/http'

class SearchRecipeClass

  def self.search_recipe
    #レシピを検索する
    result = Array.new
    10.times{|i|
      result += Twitter.search('cookpad.com/recipe/', {:rpp => 100, :page => i+1})
    }
    result.each do |r|
      #URIを取る
      uri = URI.extract(r.text, %w[http]).first
      #レシピ名を取る
      #doc = Nokogiri::HTML(open(uri))
      #title = doc.title => 保管する必要ねえや。並び替えの時に。
      #短縮でないuriを取る
      real_url = getExpandUrl(uri)
      if real_url == nil
        #ログに書く
        p r.id
      end
      #DBに入れる
      recipe = Recipe.new
      recipe.url = real_url
      recipe.tweet_id = r.id
      recipe.save
    end
  end

  #短縮URL→本URLに戻す処理
  def self.getExpandUrl(urlStr)
    expandUrl = nil    
    errCd = nil
    begin
      response = Net::HTTP::get_response(URI.parse(urlStr))
      case response
      when Net::HTTPSuccess then
        #通常URLの場合
        expandUrl = urlStr
      when Net::HTTPRedirection then
        #短縮URLの場合
        expandUrl = getExpandUrl(response['location'])
      else #その他
        response.error!
S      end
    rescue => errCd
      p errCd
      p urlStr
      p expandUrl
    end
    return expandUrl
  end
end

#SearchRecipeClass.search_recipe
