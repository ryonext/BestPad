require 'spec_helper'

describe RecipesController do

  context '' do
    describe 'index' do
      context '' do
        before(:each) do
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
      end
    end
  end

end
