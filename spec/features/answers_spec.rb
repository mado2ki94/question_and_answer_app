require 'rails_helper'

RSpec.feature "Answers", type: :feature do
  include LoginSupport
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user_id: other_user.id) }
  
  # ユーザーは新しい回答を投稿する
  scenario "user add a new answer" do

    expect {
      sign_in_as user

      visit "questions/#{question.id}"
      fill_in "回答", with: "Test answer"
      click_button "回答する"

      expect(page).to have_content "回答しました。"
    }.to change(question.answers, :count).by(1)
  end

  # ユーザーは自分の回答を削除する
  scenario "user destroy user's answer" do
    answer = FactoryGirl.create(:answer, question_id: question.id, user_id: user.id)

    expect {
      sign_in_as user

      visit "questions/#{question.id}"
      click_link "回答を削除する", match: :first

      expect(page).to have_content "削除しました"
    }.to change(question.answers, :count).by(-1)
  end
end
