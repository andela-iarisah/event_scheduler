FactoryGirl.define do
  factory :incomplete_group_event, class: 'GroupEvent' do
    start_on Date.today + 2
    end_on Date.today + 5
    description "MyText"
    location "MyString"

    trait :complete do
      name "MyString"
    end

    trait :invalid do
      end_on Date.today + 1
    end

    factory :invalid_group_event, traits: [:invalid]
    factory :complete_group_event, traits: [:complete]
  end
end
