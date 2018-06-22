require 'rails_helper'

RSpec.describe Like, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:like)).to be_valid
  end

  # user_idがなければ無効な状態であること
  it "is valid without a user id" do
    like = FactoryGirl.build(:like, user_id: nil)
    like.save
    expect(like.errors[:user_id]).to include("を入力してください")
  end

  # answer_idがなければ無効な状態であること
  it "is valid without a answer id" do
    like = FactoryGirl.build(:like, answer_id: nil)
    like.save
    expect(like.errors[:answer_id]).to include("を入力してください")
  end

  # 同じ組み合わせのlikeは無効な状態であること
  # it "is valid with a duplicate combination" do
  #   user = FactoryGirl.create(:user)
  #   answer = FactoryGirl.create(:answer)
  #   like1 = FactoryGirl.create(:like, user_id: user.id, answer_id: answer.id)
  #   like2 = FactoryGirl.build(:like, user_id: user.id, answer_id: answer.id)
  #   expect(like2.valid?).to be_falsey
  # end
end
