class StaticPagesController < ApplicationController

  PER = 10

  def home
    @questions = Question.page(params[:page]).per(PER)
    @rankings = User.ranking
  end
end
