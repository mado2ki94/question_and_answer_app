require 'rails_helper'

RSpec.feature "BestAnswers", type: :feature do
  include LoginSupport
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  # ユーザーは質問をベストアンサーに決定する
  scenario "user chooses a best_answer" do
    question = FactoryGirl.create(:question, user_id: user.id)
    answer = FactoryGirl.create(:answer, user_id: other_user.id, question_id: question.id)

    sign_in_as user

    visit "questions/#{question.id}"
    click_button "ベストアンサーに決定する！"

    expect(page).to have_content("ベストアンサーを決定しました。解決した場合は回答を締め切ってください。")
  end

  # ユーザーは質問へのベストアンサーを取り消す
  scenario "user cancels a best_answer" do
    question = FactoryGirl.create(:question, user_id: user.id)
    answer = FactoryGirl.create(:answer, user_id: other_user.id, question_id: question.id)

    sign_in_as user

    visit "questions/#{question.id}"
    click_button "ベストアンサーに決定する！"
    find(".destroy-best-answer-btn").click

    expect(page).to have_content("ベストアンサーを取り消しました。")
  end
end
