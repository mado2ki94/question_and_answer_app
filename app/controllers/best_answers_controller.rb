class BestAnswersController < ApplicationController

  def create
    @question = Question.find_by(id: params[:question_id])
    @question.best_answer_id = params[:answer_id]
    @question.save
    flash[:notice] = "ベストアンサーを決定しました。解決した場合は回答を締め切ってください。"
    redirect_to @question
  end

  def destroy
    @question = Question.find_by(id: params[:question_id])
    @question.best_answer_id = "" if @question.best_answer_id
    @question.save
    flash[:notice] = "ベストアンサーを取り消しました。"
    redirect_to @question
  end
end
