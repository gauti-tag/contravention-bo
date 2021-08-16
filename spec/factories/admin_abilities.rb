FactoryBot.define do
  factory :admin_ability do
    sequence(:title) { |n| Faker::Job.position + n.to_s }
    slug { title.parameterize }
    controller_name { Faker::Job.field.underscore }
    action_name { ['index', 'new', 'create', 'edit', 'update'].shuffle.first }
  end
end
