FactoryBot.define do
  factory :admin_profile do
    sequence(:title) { |n| Faker::Job.position + n.to_s }
    slug { title.parameterize }

    factory :admin do
      title { 'Administrateur' }
      slug { 'administrateur' }
    end

    factory :guest do
      title { 'Guest' }
      slug { 'guest' }
    end
  end
end

def profile_with_abilities(abilities_count: 5)
  FactoryBot.create(:admin_profile) do |profile|
    abilities = FactoryBot.create_list(:admin_ability, abilities_count)
    abilities.each { |ability| profile.admin_abilities << ability }
  end
end