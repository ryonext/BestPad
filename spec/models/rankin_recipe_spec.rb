#encoding: utf-8
require 'spec_helper'

describe RankinRecipe do

  context 'tp is not defined' do
    describe 'tp=' do
      context 'integer' do
        before(:each) do
          @r_recipe = RankinRecipe.new
        end
        it 'should be success' do
          (@r_recipe.tp=1).should == 1
        end
        it '@r_recipe.tp == 1' do
          @r_recipe.tp = 1
          @r_recipe.tp.should == 1
        end
      end
    end
  end


#  context '' do
#    describe 'set_title_and_img' do
#      context 'correct uri' do
#        before(:each) do
#          @r_recipe = RankinRecipe.new
#          @r_recipe.set_title_and_img("http://cookpad.com/recipe/1191229")
#        end
#        it 'return rankin_recipe title' do
#          @r_recipe.title.should_not be_nil
#        end
#        it 'return rankin_recipe img' do
#          @r_recipe.img_uri.should_not be_nil
#        end
#        it 'return outer_img_path' do
#          @r_recipe.outer_img_path.should_not be_nil
#        end
#      end
#    end
#
#    describe 'get_title' do
#      context 'rankin_recipe not registerd' do
#        it 'returns title' do
#          r_recipe = RankinRecipe.get_title('http://www.yahoo.co.jp/')
#          r_recipe.should_not be_nil
#        end
#        it 'increments RankinRecipe count' do
#          count = RankinRecipe.count
#          r_recipe = RankinRecipe.get_title('http://www.yahoo.co.jp/')
#          RankinRecipe.count.should > count
#        end
#        it 'rankin_recipe is correct' do
#          r_recipe = RankinRecipe.get_title('http://www.yahoo.co.jp/')
#          r_recipe.title.should == 'Yahoo! JAPAN'
#        end
#      end
#      context 'rankin_recipe is registered' do
#        before(:each) do
#          @title = FactoryGirl.create(:google)
#        end
#        it 'returns title' do
#          RankinRecipe.get_title('http://www.google.com/').should_not be_nil
#        end
#        it 'not increments RankinRecipe count' do
#          count = RankinRecipe.count
#          RankinRecipe.get_title('http://www.google.com/')
#          RankinRecipe.count.should == count
#        end
#        it 'title is correct' do
#          RankinRecipe.get_title('http://www.google.com/').title == 'Google先生'
#        end
#      end
#    end
#  end
end
