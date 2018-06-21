class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find_by(id: session[:question_id])
    @answer = Answer.find_by(id: params[:response][:answer_id])
    params[:response][:user_id] = current_user.id
    params[:response][:question_id] = session[:question_id]
    @response = @answer.responses.build(response_params)
    if @response.save
      flash[:notice] = "返信しました。"
      redirect_to @question
    else
      redirect_to @question
    end
  end

  def destroy
    @response = Response.find_by(id: params[:id])
    @question = Question.find_by(id: @response.question_id)
    @response.destroy
    flash[:notice] = "削除しました。"
    redirect_to @question
  end

  private

    def response_params
      params.require(:response).permit(:user_id, :question_id, :answer_id, :content)
    end
end
