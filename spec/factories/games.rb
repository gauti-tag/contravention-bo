FactoryBot.define do
  factory :game do
    sequence(:name) { |n| Faker::Game.title + n.to_s }
    probability { 90.0 }
    rating { 55.0 }
    payout_rating { 61.11 }
  end
end
