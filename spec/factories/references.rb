# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reference do
    url { Faker::Internet.url }
  end
end
