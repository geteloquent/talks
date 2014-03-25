# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    title { Faker::Lorem.sentence }
    slug { Faker::Internet.slug }
    description { Faker::Lorem.sentences.join(" ") }
    deadline Date.today
    audiences { [FactoryGirl.create(:audience)] }
  end
end
