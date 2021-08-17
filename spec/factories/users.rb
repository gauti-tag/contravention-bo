FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    msisdn { '225' + Faker::Number.leading_zero_number(digits: 10) }
    password { Faker::Number.number(digits: 8) }
    firstname { Faker::Name.unique.first_name }
    lastname { Faker::Name.unique.last_name }
    association :profile, factory: :admin_profile

    factory :admin_user do
      association :profile, factory: :admin
    end

    factory :guest_user do
      association :profile, factory: :guest
    end
  end
end
