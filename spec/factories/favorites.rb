FactoryGirl.define do
  factory :favorite do
    association :user
    association :question
  end
end
