class StaticPagesController < ApplicationController

  PER = 10

  def home
    @questions = Question.page(params[:page]).per(PER)
    @user_rankings = User.ranking
    @question_rankings = Question.ranking
  end
end
