class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find_by(id: params[:question_id])
    current_user.favorite(question)
    flash[:notice] = "質問にいいねしました。"
    respond_to do |format|
      format.html { redirect_to question }
      format.js
    end
  end

  def destroy
    question = Question.find_by(id: params[:question_id])
    current_user.unfavorite(question)
    flash[:notice] = "いいねを取り消しました。"
    respond_to do |format|
      format.html { redirect_to question }
      format.js
    end
  end
end
