FactoryBot.define do
  factory :admin_profile do
    title { Faker::Job.position }
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
