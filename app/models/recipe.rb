#encoding: utf-8
require 'net/http'

class Recipe < ActiveRecord::Base
  attr_accessible :tweet_id, :url
  def self.collect(count = 10, volume = 100, register_count = 1000)
    #レシピを検索する
    result = Array.new
    max_id = Recipe.maximum(:tweet_id)
    if max_id == nil || max_id == 0
      max_id = 1
    end
    search_result = Twitter.search('cookpad.com/recipe/', {:count => volume, :since_id => max_id})
    result += search_result.statuses
    min_id = search_result.statuses.map{|t|t[:id]}.min.to_i - 1
    count.times do |i|
      search_result = Twitter.search('cookpad.com/recipe/', {:count => volume, :max_id => min_id, :since_id => max_id})
      result += search_result.statuses
      min_id = search_result.statuses.map{|t|t[:id]}.min.to_i - 1
      break if search_result.statuses.count == 0
      if result.size > register_count
        break;
      end
    end
    max_id = search_result.statuses.map{|t|t[:id]}.max
    i = 0
    result.reverse.each do |r|
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
      i+=1
      if i > register_count
        break;
      end
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
