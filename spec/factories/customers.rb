FactoryBot.define do
  factory :customer do
    first_name { Faker::Lorem.characters(number: 5) }
    last_name { Faker::Lorem.characters(number: 5) }
    first_name_kana { Faker::Lorem.characters(number: 5) }
    last_name_kana { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    post_code { Faker::Lorem.characters(number: 7) }
    address { Faker::Lorem.characters(number: 15) }
    phone_number { Faker::Lorem.characters(number: 7) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end