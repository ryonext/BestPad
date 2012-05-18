require 'spec_helper'

describe RecipesController do

  context '' do
    describe 'index' do
      context '' do
        before(:each) do
          FactoryGirl.create(:myrecipe)
          get 'index'
        end
        it 'should be_success' do
          response.should be_success
        end
        it 'rankin_recipes are available' do
          assigns[:r_recipes].should_not be_nil
        end
        it 'more than one r_recipe is available' do
          assigns[:r_recipes].size > 0
        end
        it 'r_recipe has uri' do
          assigns[:r_recipes].first.uri.should_not be_nil
        end
        it 'r_recipe has tp(tubuyaki_point)' do
          assigns[:r_recipes].first.tp.should_not be_nil
        end
        it 'r_recipe has title' do
          assigns[:r_recipes].first.title.should_not be_nil
        end
        it 'r_recipe has img_uri' do
          assigns[:r_recipes].first.img.should_not be_nil
        end
      end
      context 'recipe_title is not registered' do
        it 'recipe_title count incremented' do
          FactoryGirl.create(:myrecipe)
          count = RankinRecipe.count
          get 'index'
          RankinRecipe.count.should > count
        end
      end
      context 'recipe_title is already registered' do
        it 'recipe_title count not incremented' do
          FactoryGirl.create(:myrecipe)
          get 'index'
          count = RankinRecipe.count
          get 'index'
          RankinRecipe.count.should == count
        end
      end
    end
  end

  describe 'update_task' do
    it 'not implemeted'
  end

  context 'recipe created 1 day ago exitsts' do
    describe 'delete_task' do
      context 'correct token' do
        it 'delete recipe' do
          recipe = FactoryGirl.create(:delete_recipe)
          delete 'delete_task', :token => ENV['token']
          Recipe.find_by_id(recipe.id).should be_nil
        end
      end
      context 'incorrect token' do
        before(:each) do
          @recipe = FactoryGirl.create(:delete_recipe)
          delete 'delete_task', :token => 'fake_token'
        end
        it 'return false' do
          assigns[:result].should == false
        end
        it 'not delete recipe' do
          Recipe.find(@recipe.id).should_not be_nil
        end
      end
    end
  end

  context 'recipe created 1 day ago does not exist' do
    describe 'delete_task' do
      context 'correct token' do
        it 'not delete recipe' do
          recipe = FactoryGirl.create(:not_delete_recipe)
          delete 'delete_task', :token => ENV['token']
          Recipe.find(recipe.id).should_not be_nil
        end
      end
    end
  end

  context 'rankin_recipe created 2 day ago exists' do
    describe 'delete_task' do
      context 'correct token' do
        it 'delete rankin_recipe' do
          r_recipe = FactoryGirl.create(:two_day_r_recipe)
          delete 'delete_task', :token => ENV['token']
          RankinRecipe.find_by_id(r_recipe.id).should be_nil
        end
      end
    end
  end

  context 'rankin_recipe created 1 day ago exitst' do
    describe 'delete_task' do
      context 'correct token' do
        it 'not delete rankin_recipe' do
          r_recipe = FactoryGirl.create(:one_day_r_recipe)
          delete 'delete_task', :token => ENV['token']
          RankinRecipe.find_by_id(r_recipe.id).should_not be_nil
        end
      end
    end
  end

end
