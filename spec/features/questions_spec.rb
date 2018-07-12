require 'rails_helper'

RSpec.feature "Questions", type: :feature do
  include LoginSupport
  let(:user) { FactoryGirl.create(:user) }

  # ユーザーは新しい質問を投稿する
  scenario "user create a new question" do
    sign_in_as user

    expect {
      find(".new-link-for-rspec").click
      fill_in "タイトル", with: "Test question"
      fill_in "本文", with: "Test content"
      click_button "投稿する"

      expect(page).to have_content "投稿しました。"
    }.to change(user.questions, :count).by(1)
  end

  # ユーザーは自分の質問を削除する
  scenario "user destroy user's question" do
    question = FactoryGirl.create(:question, user_id: user.id)

    sign_in_as user

    expect {
      visit "questions/#{question.id}"
      click_link "削除"

      expect(page).to have_content "削除しました。"
    }.to change(user.questions, :count).by(-1)
  end
end
