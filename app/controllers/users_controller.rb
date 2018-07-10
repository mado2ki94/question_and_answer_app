class UsersController < ApplicationController

  PER = 10

  def show
    @user = User.find_by(id: params[:id])
    @questions = Question.where(user_id: @user.id).page(params[:page]).per(PER)
  end

  def likes
    @user = User.find_by(id: params[:id])
    @questions = @user.favoritings.page(params[:page]).per(PER)
  end
end
