#encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :google, :class => RecipeTitle do
    uri "http://www.google.com/"
    title "Google先生"
  end
end
