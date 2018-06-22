class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    answer = Answer.find_by(id: params[:answer_id])
    current_user.like(answer)
    flash[:notice] = "いいねしました。"
    redirect_to answer.question
  end

  def destroy
    answer = Answer.find_by(id: params[:answer_id])
    current_user.unlike(answer)
    flash[:notice] = "いいねを取り消しました。"
    redirect_to answer.question
  end

end
