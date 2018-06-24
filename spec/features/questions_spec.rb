require 'rails_helper'

RSpec.feature "Questions", type: :feature do
  # ユーザーは新しい質問を投稿する
  scenario "user create a new question" do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {
      click_link "質問する"
      fill_in "タイトル", with: "Test question"
      # fill_in "タグ", with: "Test Tag"
      fill_in "本文", with: "Test content"
      click_button "投稿する"

      expect(page).to have_content "投稿しました。"
    }.to change(user.questions, :count).by(1)
  end

  # ユーザーは自分の質問を削除する
  scenario "user destroy user's question" do
    user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: user.id)

    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {
      visit "questions/#{question.id}"
      click_link "削除"

      expect(page).to have_content "削除しました。"
    }.to change(user.questions, :count).by(-1)
  end
end
