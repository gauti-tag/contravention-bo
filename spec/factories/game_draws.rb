FactoryBot.define do
  factory :game_draw do
    balls { Faker::Number.number(digits: 10).to_s.scan(/.{1,2}/) }
    published_at { "2021-08-23" }
    drawn_at { "2021-08-23 10:40:25" }
    sequence(:identifier) { |n| Faker::Number.number(digits: 10).to_s + n.to_s }
    association :game, factory: :game
  end
end
