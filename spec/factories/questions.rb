FactoryGirl.define do
  factory :question do
    title "test-title"
    tag "training-method"
    content "how many do you training in a week?"
    resolution 0
    association :user

    trait :invalid do
      title nil
    end
  end
end
