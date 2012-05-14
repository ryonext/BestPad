#encoding: utf-8

FactoryGirl.define do
  factory :myrecipe, :class => Recipe do
    url "http://www.google.com/"
    tweet_id 123
  end
  factory :delete_recipe, :class => Recipe do
    url "http://www.yahoo.co.jp/"
    tweet_id 234
    created_at 1.day.ago
  end
  factory :not_delete_recipe, :class => Recipe do
    url "http://www.yahoo.co.jp/"
    tweet_id 456
    created_at 12.hour.ago
  end
end
