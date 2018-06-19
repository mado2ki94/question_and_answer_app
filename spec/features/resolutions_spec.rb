require 'rails_helper'

RSpec.feature "Resolutions", type: :feature do
  # 質問を締め切ること
  it "closes a question" do
    user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: user.id)

    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    visit "questions/#{question.id}"
    click_link "締め切る"
    expect(page).to have_content "質問を締め切りました"
    expect(question.reload.resolution).to eq 1
  end
end
