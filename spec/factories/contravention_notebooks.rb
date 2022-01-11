FactoryBot.define do
  factory :contravention_notebook do
    number { "MyString" }
    label { "MyString" }
    sheets { 1 }
    contravention_group { nil }
  end
end
