FactoryGirl.define do
  factory :response do
    content "MyText"
    association :user
    association :question
    association :answer
  end
end
