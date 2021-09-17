FactoryBot.define do
  factory :audit_log do
    user_ip { Faker::Internet.ip_v4_cidr }
    description { Faker::Lorem.sentence }
    sequence(:module_title) { |n| Faker::Job.position + n.to_s }
    tag { [0, 1, 2].shuffle.last }
    sequence(:identifier) { |n| Faker::IDNumber.valid + n.to_s }
    association :user, factory: :user
  end
end
