#encoding: utf-8

FactoryGirl.define do
  factory :myrecipe, :class => Recipe do
    url "http://www.google.com/"
    tweet_id 123
  end
end
