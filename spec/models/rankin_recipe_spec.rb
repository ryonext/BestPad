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

  context 'rankin_recipe already saved' do
    it 'not implemented'
  end

  context 'rankin_recipe is not saved' do
    describe 'save_with_img' do
      before(:each) do
          @before_count = RankinRecipe.count
          @r_recipe = RankinRecipe.new
          @r_recipe.title = 'mytitle'
          @r_recipe.uri = 'http://www.yahoo.co.jp'
      end
      context 'correct img uri' do
        before(:each) do
          @r_recipe.img_uri = "/assets/images/test/recipe/test.jpg"
          @r_recipe.save_with_img('http://t1.gstatic.com/images?q=tbn:ANd9GcTrMRO783RkStiU2KvL8Mr2sEEBP6ElaV703uixa-QtjsaoWQ94iw')
          @saved_recipe = RankinRecipe.find(@r_recipe.id)
        end
        it 'saved' do
          @saved_recipe.should == @r_recipe
        end
        it 'title exists' do
          @saved_recipe.title.should == 'mytitle'
        end
        it 'img_uri exists' do
          @saved_recipe.img_uri.should == '/assets/images/test/recipe/test.jpg'
        end
        it 'img_file exists' do
          File.exists?("public#{@saved_recipe.img_uri}").should == true
        end
        it 'RankinRecipe.count is incremented' do
          RankinRecipe.count.should == @before_count + 1
        end
      end
      context 'no img uri' do
        before(:each) do
          @r_recipe.img_uri = nil
          @r_recipe.save_with_img(nil)
          @saved_recipe = RankinRecipe.find(@r_recipe.id)
        end
        it 'saved' do
          @saved_recipe.should == @r_recipe
        end
        it 'title exists' do
          @saved_recipe.title.should == 'mytitle'
        end
        it 'img_uri is null' do
          @saved_recipe.img_uri.should be_nil
        end
        it 'RankinRecipe.count is incremented' do
          RankinRecipe.count.should == @before_count + 1
        end
      end
      context 'irregal img uri' do
        it 'saved'
        it 'title exists'
        it 'img_uri is null'
        it 'img_file does not exitst'
        it 'RankinRecipe.count is incremented'
      end
      context 'uri is null' do
        it 'does not saved'
        it 'RankinRecipe.count is not incremeted'
      end
      context 'title is null' do
        it 'does not saved'
        it 'RankinRecipe.count is not incremented'
      end
    end
  end
end
