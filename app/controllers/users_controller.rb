class UsersController < ApplicationController

  PER = 10
  
  def show
    @user = User.find_by(id: params[:id])
    @questions = Question.page(params[:page]).per(PER)
  end
end
