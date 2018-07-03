require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  # 名前がなければ無効な状態であること
  it { is_expected.to validate_presence_of :name }

  # メールアドレスがなければ無効な状態であること
  it { is_expected.to validate_presence_of :email }

  # パスワードがなければ無効な状態であること
  it { is_expected.to validate_presence_of :password }

  # 6文字未満のパスワードは無効であること(5文字の場合)
  it "is invalid when password is 5 characters" do
    user = FactoryGirl.build(:user, password: "a" * 5)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end

  # 6文字のパスワードは有効であること
  it "is valid when password is 6 characters" do
    expect(FactoryGirl.build(:user, password: "a" * 6)).to be_valid
  end

  # ユーザーは多くの質問をもつ
  it { is_expected.to have_many :questions }

  # ユーザーは多くの回答をもつ
  it { is_expected.to have_many :answers }

  # ユーザーは多くの返信をもつ
  it { is_expected.to have_many :responses }
end
