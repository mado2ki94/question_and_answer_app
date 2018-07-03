require 'rails_helper'

RSpec.feature "Resolutions", type: :feature do
  include LoginSupport

  # 質問を締め切ること
  it "closes a question" do
    user = FactoryGirl.create(:user)
    question = FactoryGirl.create(:question, user_id: user.id)

    sign_in_as user

    visit "questions/#{question.id}"
    click_link "締め切る"
    expect(page).to have_content "質問を締め切りました"
    expect(question.reload.resolution).to eq 1
  end
end
