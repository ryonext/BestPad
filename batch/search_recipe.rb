require 'open-uri'
require 'net/http'

class SearchRecipeBatch

  def self.search_recipe(count = 10, volume = 100)
    #レシピを検索する
    result = Array.new
    count.times{|i|
      result += Twitter.search('cookpad.com/recipe/', {:rpp => volume, :page => i+1})
    }
    result.each do |r|
      #URIを取る
      uri = URI.extract(r.text, %w[http]).first.gsub("(", "").gsub(")","")
      #短縮でないuriを特異メソッドで取る
      def uri.expand
        return SearchRecipeBatch.getExpandUri(self)
      end
      real_uri = uri.expand
      if real_uri == nil
        #ログに書く
        p uri
        #p r.id
        #次の人どうぞ～
        next
      end
      #DBに入れる
      recipe = Recipe.new
      recipe.url = real_uri
      recipe.tweet_id = r.id
      recipe.save
    end
  end

  #短縮URL→本URLに戻す処理
  def self.getExpandUri(uri)
    expandUri = nil    
    errCd = nil
    begin
      response = Net::HTTP::get_response(URI.parse(uri))
      case response
      when Net::HTTPSuccess then
        #通常URIの場合
        expandUri = uri
      when Net::HTTPRedirection then
        #短縮URIの場合
        expandUri = getExpandUri(response['location'])
      else #その他
        response.error!
      end
    rescue => errCd
      #ログに書く
      p errCd
#      p urlStr
#      p expandUrl
    end
    return expandUri
  end
end

#SearchRecipeBatch.search_recipe
