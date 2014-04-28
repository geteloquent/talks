# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name::name }
    username { Faker::Internet::user_name }
    email { Faker::Internet::email }
    avatar_url { "#{Faker::Internet::url}.jpg" }
    github_uid { Faker::Number::number(7).to_s }
  end
end
