require 'rails_helper'

RSpec.describe Response, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:response)).to be_valid
  end

  # contentがなければ無効な状態であること
  it { is_expected.to validate_presence_of :content }

  # contentが10001字以上であれば無効な状態であること(10001字の場合)
  it "is invalid when content has 10001 characters" do
    response = FactoryGirl.build(:response, content: "a" * 10001)
    response.save
    expect(response.errors[:content]).to include("は10000文字以内で入力してください")
  end

  # contentが10000字以下であれば有効な状態であること(10000字の場合)
  it "is valid when content has 10000 characters" do
    expect(FactoryGirl.build(:response, content: "a" * 10000)).to be_valid
  end

  # user_idがなければ無効な状態であること
  it { is_expected.to validate_presence_of :user_id }

  # question_idがなければ無効な状態であること
  it { is_expected.to validate_presence_of :question_id }

  # answer_idがなければ無効な状態であること
  it { is_expected.to validate_presence_of :answer_id }

  # 返信はユーザーに属している
  it { is_expected.to belong_to :user }

  # 返信は質問に属している
  it { is_expected.to belong_to :question }

  # 返信は回答に属している
  it { is_expected.to belong_to :answer }
end
