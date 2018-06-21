class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @questions = Question.all
  end
end
