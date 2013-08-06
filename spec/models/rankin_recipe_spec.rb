#encoding: utf-8
require 'spec_helper'
require 'webmock'

describe RankinRecipe do

  describe 'uri' do
    context 'nil' do
      it 'should not be_valid' do
        r_recipe = RankinRecipe.new
        r_recipe.title = "test"
        r_recipe.should_not be_valid
      end
    end
  end


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

  describe 'save' do
    context 'rankin_recipe is not saved' do
      before(:each) do
          @before_count = RankinRecipe.count
          @r_recipe = RankinRecipe.new
          @r_recipe.title = 'mytitle'
          @r_recipe.uri = "http://www.example.com/"
      end
      context 'correct img uri' do
        before(:each) do
          @r_recipe.img =  open("http://www.example.com/").read
          @r_recipe.save
          @saved_recipe = RankinRecipe.find(@r_recipe.id)
        end
        it 'saved' do
          @saved_recipe.should == @r_recipe
        end
        it 'title exists' do
          @saved_recipe.title.should == 'mytitle'
        end
        it 'img exists' do
          @saved_recipe.img.should_not be_nil
        end
        it 'RankinRecipe.count is incremented' do
          RankinRecipe.count.should == @before_count + 1
        end
      end
      context 'no img uri' do
        before(:each) do
          @r_recipe.save
          @saved_recipe = RankinRecipe.find(@r_recipe.id)
        end
        it 'saved' do
          @saved_recipe.should == @r_recipe
        end
        it 'title exists' do
          @saved_recipe.title.should == 'mytitle'
        end
        it 'img is null' do
          @saved_recipe.img.should be_nil
        end
        it 'RankinRecipe.count is incremented' do
          RankinRecipe.count.should == @before_count + 1
        end
      end
      context 'irregal img uri' do
        before(:each) do
          @r_recipe.img = open('http://www.example.com/').read
          @r_recipe.save
          @saved_recipe = RankinRecipe.find(@r_recipe.id)
        end
        it 'saved' do
          @saved_recipe.should == @r_recipe
        end
        it 'title exists' do
          @saved_recipe.title.should == 'mytitle'
        end
        it 'img is not null' do
          @saved_recipe.img.should_not be_nil
        end
        it 'RankinRecipe.count is incremented' do
          RankinRecipe.count.should == @before_count + 1
        end
      end
      context 'uri is null' do
        before(:each) do
          @r_recipe.uri = nil
        end
        it 'does not saved' do
          @r_recipe.save.should == false
        end
        it 'RankinRecipe.count is not incremeted' do
          @r_recipe.save
          RankinRecipe.count.should == @before_count
        end
      end
      context 'title is null' do
        before(:each) do
          @r_recipe.title = nil
        end
        it 'does not saved' do
          @r_recipe.save.should == false
        end
        it 'RankinRecipe.count is not incremented' do
          @r_recipe.save
          RankinRecipe.count.should == @before_count
        end
      end
    end
    
    context 'rankin_recipe already saved without img' do
      before(:each) do
        @r_recipe = FactoryGirl.create(:without_img_recipe)
      end
      context 'correct img uri' do
        before(:each) do
          @r_recipe.img = open('http://www.example.com/img').read
        end
        it 'saved' do
          @r_recipe.save.should == true
        end
        it 'img is exist' do
          @r_recipe.save
          recipe = RankinRecipe.find(@r_recipe.id)
          recipe.img.should_not be_nil
        end
        it 'RankinRecipe count is not incremented' do
          before_count = RankinRecipe.count
          @r_recipe.save
          RankinRecipe.count.should == before_count
        end
      end
      context 'irregal img uri' do
        before(:each) do
          @r_recipe.img = open('http://www.example.com/img').read
        end
        it 'saved' do
          @r_recipe.save.should == true
        end
        it 'img exist' do
          @r_recipe.save
          recipe = RankinRecipe.find(@r_recipe.id)
          recipe.img.should_not be_nil
        end
        it 'RankinRecipe count is not incremented' do
          before_count = RankinRecipe.count
          @r_recipe.save
          RankinRecipe.count.should == before_count
        end
      end
      context 'no img uri' do
        it 'saved' do
          @r_recipe.save.should == true
        end
        it 'img is not exist' do
          @r_recipe.save
          recipe = RankinRecipe.find(@r_recipe.id)
          recipe.img.should be_nil
        end
      end
    end
  end

end
