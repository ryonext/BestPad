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

end
