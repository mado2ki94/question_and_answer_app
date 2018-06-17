class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "投稿しました。"
      redirect_to root_url
    else
      flash[:danger] = "失敗しました。"
      render 'static_pages/home'
    end
  end

  def show
    @question = Question.find_by(id: params[:id])
    @user = User.find_by(id: @question.user_id)
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "編集しました。"
      redirect_to root_url
    else
      flash[:danger] = "失敗しました。"
      render 'static_pages/home'
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    @question.destroy
    flash[:success] = "削除しました。"
    redirect_to root_url
  end

  private

    def question_params
      params.require(:question).permit(:title, :tag, :content)
    end

    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end
end
