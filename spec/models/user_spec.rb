require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  # 名前がなければ無効な状態であること
  it "is invalid without a name" do
    expect(FactoryGirl.build(:user, name: nil)).to be_invalid
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without a email" do
    expect(FactoryGirl.build(:user, email: nil)).to be_invalid
  end

  # パスワードがなければ無効な状態であること
  it "is invalid without a password" do
    expect(FactoryGirl.build(:user, password: nil)).to be_invalid
  end

  # 6文字未満のパスワードは無効であること(5文字の場合)
  it "is invalid when password is 5 characters" do
    user = FactoryGirl.build(:user, password: "a" * 5)
    user.valid?
    expect(user.errors[:password]).to include("translation missing: ja.activerecord.errors.models.user.attributes.password.too_short")
  end

  # 6文字のパスワードは有効であること
  it "is valid when password is 6 characters" do
    expect(FactoryGirl.build(:user, password: "a" * 6)).to be_valid
  end
end
