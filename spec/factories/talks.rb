# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    title Faker::Lorem.sentence
    slug { Faker::Internet.slug }
    description Faker::Lorem
    deadline "2014-03-14"
  end
end
