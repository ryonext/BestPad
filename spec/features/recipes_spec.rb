#encoding: utf-8
require 'spec_helper'
require 'webmock'

describe 'Recipe' do
  describe "get index" do
    context "Recipe is available" do
      before do
        @myrecipe = FactoryGirl.create(:myrecipe)
        visit "/recipes/index"
      end
      it "response should success" do
        status_code.should be 200
      end
      it "page displays recipe uri" do
        page.should have_content @myrecipe.url
      end
    end
    context "No recipe" do
      before{visit "/recipes/index"}
      it "response should success" do
        status_code.should be 200
      end
    end
  end

  describe "post /tasks/update" do
    subject{status_code}
    before do
      VCR.use_cassette("tasks_update") do
        page.driver.post "/tasks/update", {:token => token}
      end
    end
    context "normal case" do
      let(:token){nil}
      it{should be 201}
    end
    context "token is invalid" do
      let(:token){"invalid"}
      it{should be 400}
    end
  end

  describe "delete /tasks/delete" do
    subject{status_code}
    before do
      @delete_recipe = FactoryGirl.create(:delete_recipe)
      @not_delete_recipe = FactoryGirl.create(:not_delete_recipe)
      page.driver.delete "/tasks/delete", {:token => token}
    end
    context "normal case" do
      let(:token){nil}
      it{should be 204}
      it "deleted recipe that created over 24 hours ago" do
        Recipe.find_by_id(@delete_recipe.id).should be_nil
      end
      it "should not delete recipe that created in 24 hours" do
        Recipe.find_by_id(@not_delete_recipe.id).should be
      end
    end
    context "token is invalid" do
      let(:token){'invalid'}
      it{should be 400}
    end
  end

end
