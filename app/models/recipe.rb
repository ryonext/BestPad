require 'net/http'

class Recipe < ActiveRecord::Base
  attr_accessible :tweet_id, :url

    def self.collect(count = 10, volume = 100)
    #レシピを検索する
    result = Array.new
    maxId = Recipe.maximum(:tweet_id)
    count.times{|i|
      result += Twitter.search('cookpad.com/recipe/', {:rpp => volume, :page => i+1, :since_id => maxId})
    }
    result.each do |r|
      #URIを取る
      uri = URI.extract(r.text, %w[http]).first
      #.や@などの文字列を取る
      uri = self.format_uri(uri)
      #短縮でないuriを特異メソッドで取る
      def uri.expand
        return Recipe.getExpandUri(self)
      end
      real_uri = uri.expand
      #展開後に変な文字が付いているケースがあるのでもう一度綺麗にする。
      real_uri = self.format_uri(real_uri)
      if real_uri == nil
        #ログに書く
        logger.error "Tweet_ID:#{r.id},text:#{r.text}"
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
      logger.error "ERR_CD:#{errCd},uri:#{uri}"
    end
    return expandUri
  end

  def self.format_uri(uri)
    return if uri == nil
    case uri.last
    when ':', '.', '(', ')', '@'
      uri[-1] = ''
      self.format_uri(uri)
    end
    uri.gsub!(/[?].*/, '')
    return uri
  end

end
