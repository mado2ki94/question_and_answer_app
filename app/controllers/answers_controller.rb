class AnswersController < ApplicationController
  before_action :authenticate_user!


  def create
    @question = Question.find_by(id: params[:answer][:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.save ? flash[:notice] = "回答しました。" : flash[:alert] = "失敗しました。"
    redirect_to @question
  end

  def destroy
    @answer = Answer.find_by(id: params[:id])
    @question = Question.find_by(id: @answer.question_id)
    @answer.destroy
    flash[:notice] = "削除しました。"
    redirect_to @question
  end

  private

    def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id)
    end

end
