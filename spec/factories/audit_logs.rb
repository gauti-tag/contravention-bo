FactoryBot.define do
  factory :audit_log do
    user_ip { "MyString" }
    description { "MyText" }
    module_title { "MyString" }
    tag { 1 }
    user { nil }
  end
end
