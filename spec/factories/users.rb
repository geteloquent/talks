# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name::name }
    username { Faker::Internet::user_name }
    email { Faker::Internet::email }
    avatar_url { "#{Faker::Internet::url}.jpg" }
  end
end
