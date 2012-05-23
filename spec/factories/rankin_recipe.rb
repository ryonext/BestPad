#encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :google, :class => RankinRecipe do
    uri "http://cookpad.com/recipe/1191229"
    title "★簡単＊トマトリゾット★ by ★★hana★★"
  end

  factory :two_day_r_recipe, :class => RankinRecipe do
    uri "http://www.yahoo.co.jp/"
    title "消されるレシピ"
    created_at 2.day.ago
  end
  factory :one_day_r_recipe, :class => RankinRecipe do
    uri "http://www.yahoo.co.jp/"
    title "消されないレシピ"
    created_at 1.day.ago
  end
  factory :without_img_recipe, :class => RankinRecipe do
    uri "http://www.google.com"
    title "画像なし"
  end
end
