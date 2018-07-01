class ResolutionsController < ApplicationController
  def close
    @question = Question.find_by(id: params[:question_id])
    @question.update_attributes(resolution: "1")
    flash[:notice] = "質問を締め切りました"
    redirect_to @question
  end
end
