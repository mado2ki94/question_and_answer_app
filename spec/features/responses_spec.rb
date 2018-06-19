require 'rails_helper'

RSpec.feature "Responses", type: :feature do
  # ユーザーは新しい返信を投稿する
  scenario "user create a new response" do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: other_user.id)
    answer = FactoryGirl.create(:answer, user_id: user.id, question_id: question.id)

    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {
      visit "questions/#{question.id}"
      fill_in "返信", with: "Test response"
      click_button "返信する"

      expect(page).to have_content "返信しました。"
    }.to change(user.responses, :count).by(1)
  end

  # ユーザーは自分の返信を削除する
  scenario "user destroy user's response" do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: other_user.id)
    answer = FactoryGirl.create(:answer, user_id: user.id, question_id: question.id)
    response = FactoryGirl.create(:response, answer_id: answer.id, question_id: question.id, user_id: user.id)

    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {
      visit "questions/#{question.id}"
      click_link "返信を削除する"

      expect(page).to have_content "削除しました。"
    }.to change(user.responses, :count).by(-1)
  end
end
