# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    title { Faker::Lorem.sentence }
    slug { Faker::Lorem::words(2).join }
    description { Faker::Lorem.sentences(10).join(" ") }
    deadline { Date.today + Random.rand(90).days }
  end
end
