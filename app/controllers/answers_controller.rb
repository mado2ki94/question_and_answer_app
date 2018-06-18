class AnswersController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user


  def create
    @question = Question.find_by(id: session[:question_id])
    params[:answer][:question_id] = session[:question_id]
    params[:answer][:user_id]     = current_user.id
    @answer = @question.answers.build(params.require(:answer).permit(:content, :question_id, :user_id))
    if @answer.save
      flash[:success] = "回答しました。"
      redirect_to @question
    else
      # render "/users/new"
      redirect_to @question
    end
  end

  def destroy
    @answer = Answer.find_by(id: params[:id])
    @question = Question.find_by(id: @answer.question_id)
    @answer.destroy
    flash[:success] = "削除しました。"
    redirect_to @question
  end

  private

    def answer_params
      params.require(:answer).permit(:content)
    end

    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end


end
