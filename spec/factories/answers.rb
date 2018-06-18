FactoryGirl.define do
  factory :answer do
    content "Test answer"
    association :user
    association :question
  end
end
