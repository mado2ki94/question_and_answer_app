class ResolutionsController < ApplicationController
  def close
    @question = Question.find_by(id: session[:question_id])
    @question.update_attributes(resolution: "1")
    # debugger
    flash[:success] = "質問を締め切りました"
    redirect_to @question
  end
end
