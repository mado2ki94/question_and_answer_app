require 'rails_helper'

RSpec.feature "Favorites", type: :feature do
  include LoginSupport
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  # ユーザーは質問にfavoriteする
  scenario "user favorite a question" do
    question = FactoryGirl.create(:question, user_id: other_user.id)

    expect {
      sign_in_as user

      visit "questions/#{question.id}"
      find(".favorite-btn").click

      expect(page).to have_content("質問にいいねしました。")
    }.to change(user.favoritings, :count).by(1)
  end

  # ユーザーは質問へのfavoriteを取り消す
  scenario "user unfavorite a question" do
    question = FactoryGirl.create(:question, user_id: other_user.id)
    favorite = FactoryGirl.create(:favorite, user_id: user.id, question_id: question.id)

    expect {
      sign_in_as user

      visit "questions/#{question.id}"
      find(".unfavorite-btn").click

      expect(page).to have_content("この質問へのいいねを取り消しました。")
    }.to change(user.favoritings, :count).by(-1)
  end
end
