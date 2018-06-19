require 'rails_helper'

RSpec.describe Response, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:response)).to be_valid
  end

  # contentがなければ無効な状態であること
  it "is invalid without a content" do
    response = FactoryGirl.build(:response, content: nil)
    response.save
    expect(response.errors[:content]).to include("translation missing: ja.activerecord.errors.models.response.attributes.content.blank")
  end

  # contentが10001字以上であれば無効な状態であること(10001字の場合)
  it "is invalid when content has 10001 characters" do
    response = FactoryGirl.build(:response, content: "a" * 10001)
    response.save
    expect(response.errors[:content]).to include("translation missing: ja.activerecord.errors.models.response.attributes.content.too_long")
  end

  # contentが10000字以下であれば有効な状態であること(10000字の場合)
  it "is valid when content has 10000 characters" do
    expect(FactoryGirl.build(:response, content: "a" * 10000)).to be_valid
  end

  # user_idがなければ無効な状態であること
  it "is invalid without a user_id" do
    response = FactoryGirl.build(:response, user_id: nil)
    response.save
    expect(response.errors[:user_id]).to include("translation missing: ja.activerecord.errors.models.response.attributes.user_id.blank")
  end

  # question_idがなければ無効な状態であること
  it "is invalid without a question_id" do
    response = FactoryGirl.build(:response, question_id: nil)
    response.save
    expect(response.errors[:question_id]).to include("translation missing: ja.activerecord.errors.models.response.attributes.question_id.blank")
  end

  # answer_idがなければ無効な状態であること
  it "is invalid without a response" do
    response = FactoryGirl.build(:response, answer_id: nil)
    response.save
    expect(response.errors[:answer_id]).to include("translation missing: ja.activerecord.errors.models.response.attributes.answer_id.blank")
  end
end
