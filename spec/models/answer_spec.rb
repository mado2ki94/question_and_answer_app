require 'rails_helper'

RSpec.describe Answer, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:answer)).to be_valid
  end

  # contentがなければ無効な状態であること
  it "is invalid without a content" do
    answer = FactoryGirl.build(:answer, content: nil)
    answer.save
    expect(answer.errors[:content]).to include("translation missing: ja.activerecord.errors.models.answer.attributes.content.blank")
  end

  # contentが10001字以上であれば無効な状態であること(10001字の場合)
  it "is invalid when content has 10001 characters" do
    answer = FactoryGirl.build(:answer, content: "a" * 10001)
    answer.save
    expect(answer.errors[:content]).to include("translation missing: ja.activerecord.errors.models.answer.attributes.content.too_long")
  end

  # contentが10000字以下であれば有効な状態であること(10000字の場合)
  it "is valid when content has 10000 characters" do
    expect(FactoryGirl.build(:answer, content: "a" * 10000)).to be_valid
  end

  # user_idがなければ無効な状態であること
  it "is invalid without a user_id" do
    answer = FactoryGirl.build(:answer, user_id: nil)
    answer.save
    expect(answer.errors[:user_id]).to include("translation missing: ja.activerecord.errors.models.answer.attributes.user_id.blank")
  end

  # question_idがなければ無効な状態であること
  it "is invalid without a question_id" do
    answer = FactoryGirl.build(:answer, question_id: nil)
    answer.save
    expect(answer.errors[:question_id]).to include("translation missing: ja.activerecord.errors.models.answer.attributes.question_id.blank")
  end

end
