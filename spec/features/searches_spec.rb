require 'rails_helper'

RSpec.feature "Searches", type: :feature do
  include LoginSupport
  let(:user) { FactoryGirl.create(:user) }

  # ユーザーは質問を検索する
  scenario "user search questions" do
    question = FactoryGirl.create(:question, title: "title for search")

    sign_in_as user
    visit "/"
    find(".question-search-form").set("for")
    click_button "検索"
    expect(page).to have_content("「for」の検索結果")
    expect(page).to have_content("title for search")

    visit "/"
    find(".question-search-form").set("of")
    click_button "検索"
    expect(page).to have_content("「of」の検索結果")
    expect(page).to have_content("見つかりませんでした。")
  end
end
