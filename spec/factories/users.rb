FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    msisdn { '225' + Faker::Number.leading_zero_number(digits: 10) }
    password { Faker::Number.number(digits: 8) }
    firstname { Faker::Name.unique.first_name }
    lastname { Faker::Name.unique.last_name}
  end
end
