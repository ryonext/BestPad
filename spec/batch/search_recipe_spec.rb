require 'spec_helper'
require './batch/search_recipe.rb'

describe SearchRecipeClass do
  describe 'expand_url' do
    context 'no shorten' do
      it 'get origial url' do
        expand_url = SearchRecipeClass.getExpandUrl('http://www.yahoo.co.jp/')
        expand_url.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'one shorten' do
      it 'get original url' do
        expand_url = SearchRecipeClass.getExpandUrl('http://bit.ly/INPsu')
        expand_url.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'two shorten' do
      it 'get original url' do
        expand_url =  SearchRecipeClass.getExpandUrl('http://seo-air.jp/MA71ue')
        expand_url.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'no arg' do
      it 'get nil' do
        expand_url = SearchRecipeClass.getExpandUrl(nil)
        expand_url.should be_nil
      end
    end
    
    context '404 url' do
      it 'get nil' do
        expand_url = SearchRecipeClass.getExpandUrl('http://wwwwww.yahoo.co.jp/')
        expand_url.should be_nil
      end
    end

    context 'bat arg' do
      it 'get nil' 
    end 
  end


end
