#encoding: utf-8
require 'spec_helper'
require './batch/search_recipe.rb'

describe SearchRecipeBatch do
  describe 'expand_uri' do
    context 'no shorten' do
      it 'get origial uri' do
        expand_uri = SearchRecipeBatch.getExpandUri('http://www.yahoo.co.jp/')
        expand_uri.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'one shorten' do
      it 'get original uri' do
        expand_uri = SearchRecipeBatch.getExpandUri('http://bit.ly/INPsu')
        expand_uri.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'two shorten' do
      it 'get original uri' do
        expand_uri =  SearchRecipeBatch.getExpandUri('http://seo-air.jp/MA71ue')
        expand_uri.should == 'http://www.yahoo.co.jp/'
      end
    end
    context 'no arg' do
      it 'get nil' do
        expand_uri = SearchRecipeBatch.getExpandUri(nil)
        expand_uri.should be_nil
      end
    end
    context '404 uri' do
      it 'get nil' do
        expand_uri = SearchRecipeBatch.getExpandUri('http://wwwwww.yahoo.co.jp/')
        expand_uri.should be_nil
      end
    end
    context 'not uri' do
      it 'get nil' do
        SearchRecipeBatch.getExpandUri('urlじゃないよねこれ').should be_nil
      end
    end
    context 'integer' do
      it 'get nil' do
        SearchRecipeBatch.getExpandUri(12345).should be_nil
      end
    end
  end

  describe 'search_recipe' do
    context '1.1' do
      it 'not error' do
        SearchRecipeBatch.search_recipe(1,1)
      end
    end
  end
  

end
