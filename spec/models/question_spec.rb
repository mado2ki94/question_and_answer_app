require 'rails_helper'

RSpec.describe Question, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:question)).to be_valid
  end

  # タイトルがなければ無効な状態であること
  it { is_expected.to validate_presence_of :title }

  # 質問内容(content)がなければ無効な状態であること
  it { is_expected.to validate_presence_of :content }

  # user_idがなければ無効な状態であること
  it { is_expected.to validate_presence_of :user_id }

  # resolutionがなければ無効な状態であること
  it { is_expected.to validate_presence_of :resolution }

  # 質問は多くの回答をもつ
  it { is_expected.to have_many :answers }

  # 質問は多くの返信をもつ
  it { is_expected.to have_many :responses }

  # 質問はユーザーに属している
  it { is_expected.to belong_to :user }
end
