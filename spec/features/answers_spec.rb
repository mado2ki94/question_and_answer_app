require 'rails_helper'

RSpec.feature "Answers", type: :feature do
  # ユーザーは新しい回答を投稿する
  scenario "user add a new answer" do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: other_user.id)

    expect {
      visit root_path
      click_link "ログイン"
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"

      visit "questions/#{question.id}"
      fill_in "回答", with: "Test answer"
      click_button "回答する"
      # save_and_open_page

      expect(page).to have_content "回答しました。"
    }.to change(question.answers, :count).by(1)
  end

  # ユーザーは自分の回答を削除する
  scenario "user destroy a user's answer" do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: other_user.id)
    answer = FactoryGirl.create(:answer, question_id: question.id, user_id: user.id)

    expect {
      visit root_path
      click_link "ログイン"
      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"

      visit "questions/#{question.id}"
      click_link "回答を削除する", match: :first

      expect(page).to have_content "削除しました"
    }.to change(question.answers, :count).by(-1)
  end
end
