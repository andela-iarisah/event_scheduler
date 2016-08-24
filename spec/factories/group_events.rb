FactoryGirl.define do
  factory :incomplete_group_event, class: 'GroupEvent' do
    start_on Date.today + 2
    end_on Date.today + 5
    description Faker::Lorem.sentence(3)
    location Faker::Lorem.word

    trait :complete do
      name Faker::Name.name
    end

    trait :invalid do
      end_on Date.today + 1
    end

    factory :invalid_group_event, traits: [:invalid]
    factory :complete_group_event, traits: [:complete]
  end
end
