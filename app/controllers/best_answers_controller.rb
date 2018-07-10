class BestAnswersController < ApplicationController

  def create
    # ベストアンサーの決定
    @question = Question.find_by(id: params[:question_id])
    @question.best_answer_id = params[:answer_id]
    @question.save
    # ベストアンサーに決められたユーザーのlikerを１増やす
    @answer = Answer.find_by(id: params[:answer_id])
    # @user = User.find_by(id: @answer.id)
    @answer.user.liker += 1
    @answer.user.save
    flash[:notice] = "ベストアンサーを決定しました。解決した場合は回答を締め切ってください。"
    redirect_to @question
  end

  def destroy
    # ベストアンサーの取り消し
    @question = Question.find_by(id: params[:question_id])
    @question.best_answer_id = "" if @question.best_answer_id
    @question.save
    # ベストアンサーに決められたユーザーのlikerを１減らす
    @answer = Answer.find_by(id: params[:answer_id])
    @answer.user.liker -= 1
    @answer.user.save
    flash[:notice] = "ベストアンサーを取り消しました。"
    redirect_to @question
  end
end
