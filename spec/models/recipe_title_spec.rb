#encoding: utf-8
require 'spec_helper'

describe RecipeTitle do

  context '' do
    describe 'get_title' do
      context 'title not registerd' do
        it 'returns title' do
          title = RecipeTitle.get_title('http://www.yahoo.co.jp/')
          title.should_not be_nil
        end
        it 'increments RecipeTitle count' do
          count = RecipeTitle.count
          title = RecipeTitle.get_title('http://www.yahoo.co.jp/')
          RecipeTitle.count.should > count
        end
        it 'title is correct' do
          title = RecipeTitle.get_title('http://www.yahoo.co.jp/')
          title.title.should == 'Yahoo! JAPAN'
        end
      end
      context 'title is registered' do
        before(:each) do
          @title = FactoryGirl.create(:google)
        end
        it 'returns title' do
          RecipeTitle.get_title('http://www.google.com/').should_not be_nil
        end
        it 'not increments RecipeTitle count' do
          count = RecipeTitle.count
          RecipeTitle.get_title('http://www.google.com/')
          RecipeTitle.count.should == count
        end
        it 'title is correct' do
          RecipeTitle.get_title('http://www.google.com/').title == 'Google先生'
        end
      end
    end
  end
end
