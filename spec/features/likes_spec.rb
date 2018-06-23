require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  # ユーザーは回答をいいねする
  scenario "user likes an answer" do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: user.id)
    answer = FactoryGirl.create(:answer, question_id: question.id, user_id: other_user.id)

    expect {
      visit root_path
      click_link "ログイン"
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"

      visit "questions/#{question.id}"
      click_button "いいね"

      expect(page).to have_content "いいねしました。"
    }.to change(user.likings, :count).by(1)
  end

  # ユーザーは回答へのいいねを取り消す
  scenario "user unlikes an answer" do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: user.id)
    answer = FactoryGirl.create(:answer, question_id: question.id, user_id: other_user.id)
    like = FactoryGirl.create(:like, user_id: user.id, answer_id: answer.id)

    expect {
      visit root_path
      click_link "ログイン"
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"

      visit "questions/#{question.id}"
      click_button "いいね済み"

      expect(page).to have_content "いいねを取り消しました。"
    }.to change(user.likings, :count).by(-1)
  end

  # いいねされた回答者のlikerが1増える
  # scenario "liker increase 1 when liked" do
  #   user = FactoryGirl.create(:user)
  #   other_user = FactoryGirl.create(:user)
  #   question = FactoryGirl.create(:question, user_id: user.id)
  #   answer = FactoryGirl.create(:answer, question_id: question.id, user_id: other_user.id)
  #
  #   visit root_path
  #   click_link "ログイン"
  #   fill_in "Eメール", with: user.email
  #   fill_in "パスワード", with: user.password
  #   click_button "ログイン"
  #
  #   visit "questions/#{question.id}"
  #   click_button "いいね"
  #   expect(answer.user.liker).to eq 1
  # end
end
