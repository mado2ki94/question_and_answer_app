FactoryGirl.define do
  factory :user do
    name "example_name"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "password"

    before(:create) { |user|
      # ここで認証済みでメールを送信しない設定を行う
      # http://blog.beaglesoft.net/entry/2016/12/31/195013
      user.skip_confirmation_notification!
      user.skip_confirmation!
    }
  end
end
