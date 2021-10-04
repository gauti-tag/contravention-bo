FactoryBot.define do
  factory :draw_type do
    identifier { "MyString" }
    name { "MyString" }
    week_day { 1 }
    bets_end_at { "2021-09-29 09:45:56" }
    drawn_at { "2021-09-29 09:45:56" }
    status { false }
  end
end
