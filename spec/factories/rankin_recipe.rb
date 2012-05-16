#encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :google, :class => RankinRecipe do
    uri "http://cookpad.com/recipe/1191229"
    title "★簡単＊トマトリゾット★ by ★★hana★★"
  end
end
