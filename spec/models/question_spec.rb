require 'rails_helper'

RSpec.describe Question, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:question)).to be_valid
  end

  # タイトルがなければ無効な状態であること
  it "is invalid without a title" do
    question = FactoryGirl.build(:question, title: nil)
    question.valid?
    expect(question.errors[:title]).to include("translation missing: ja.activerecord.errors.models.question.attributes.title.blank")
  end

  # 質問内容(content)がなければ無効な状態であること
  it "is invalid without a content" do
    question = FactoryGirl.build(:question, content: nil)
    question.valid?
    expect(question.errors[:content]).to include("translation missing: ja.activerecord.errors.models.question.attributes.content.blank")
  end

  # user_idがなければ無効な状態であること
  it "is invalid without a user_id" do
    question = FactoryGirl.build(:question, user_id: nil)
    question.valid?
    expect(question.errors[:user_id]).to include("translation missing: ja.activerecord.errors.models.question.attributes.user_id.blank")
  end

  # resolutionがなければ無効な状態であること
  it "is invalid without a resolution" do
    question = FactoryGirl.build(:question, resolution: nil)
    question.valid?
    expect(question.errors[:resolution]).to include("translation missing: ja.activerecord.errors.models.question.attributes.resolution.blank")
  end
end
