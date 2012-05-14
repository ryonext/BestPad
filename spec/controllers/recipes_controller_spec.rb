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
        it 'recipes are available' do
          assigns[:recipes].should_not be_nil
        end
        it 'more than one recipe is available' do
          assigns[:recipes].size > 0
        end
        it 'recipe has url' do
          assigns[:recipes].first[0].should_not be_nil
        end
        it 'recipe has count' do
          assigns[:recipes].first[1].should_not be_nil
        end
        it 'recipe has title' do
          assigns[:recipes].first[2].should_not be_nil
        end
      end
      context 'recipe_title is not registered' do
        it 'recipe_title count incremented' do
          FactoryGirl.create(:myrecipe)
          count = RecipeTitle.count
          get 'index'
          RecipeTitle.count.should > count
        end
      end
      context 'recipe_title is already registered' do
        it 'recipe_title count not incremented' do
          FactoryGirl.create(:myrecipe)
          get 'index'
          count = RecipeTitle.count
          get 'index'
          RecipeTitle.count.should == count
        end
      end
    end
  end

  describe 'update_task' do
    it 'not implemeted'
  end

  context 'data created 1 day ago exitsts' do
    describe 'delete_task' do
      context 'correct token' do
        it 'delete data' do
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
        it 'not delete data' do
          Recipe.find(@recipe.id).should_not be_nil
        end
      end
    end
  end

  context 'data created 1 day ago does not exist' do
    describe 'delete_task' do
      context 'correct token' do
        it 'not delete data' do
          recipe = FactoryGirl.create(:not_delete_recipe)
          delete 'delete_task', :token => ENV['token']
          Recipe.find(recipe.id).should_not be_nil
        end
      end
    end
  end

  



end
