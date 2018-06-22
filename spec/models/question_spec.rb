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
    expect(question.errors[:title]).to include("を入力してください")
  end

  # 質問内容(content)がなければ無効な状態であること
  it "is invalid without a content" do
    question = FactoryGirl.build(:question, content: nil)
    question.valid?
    expect(question.errors[:content]).to include("を入力してください")
  end

  # user_idがなければ無効な状態であること
  it "is invalid without a user_id" do
    question = FactoryGirl.build(:question, user_id: nil)
    question.valid?
    expect(question.errors[:user_id]).to include("を入力してください")
  end

  # resolutionがなければ無効な状態であること
  it "is invalid without a resolution" do
    question = FactoryGirl.build(:question, resolution: nil)
    question.valid?
    expect(question.errors[:resolution]).to include("を入力してください")
  end
end
