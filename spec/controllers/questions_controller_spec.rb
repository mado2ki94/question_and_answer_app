require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe "#index" do
    # 正常にレスポンスを返すこと
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end

    # 200レスポンスを返すこと
    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "#new" do
    # 認証済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = FactoryGirl.create(:user)
      end
      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in @user
        get :new
        expect(response).to be_success
      end

      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in @user
        get :new
        expect(response).to have_http_status "200"
      end
    end
    # ゲストとして
    context "as a guest" do
      # ログインページにリダイレクトすること
      it "redirects to root url" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    # 認証済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = FactoryGirl.create(:user)
      end

      # 有効な属性値の場合
      context "with valid attributes" do
        # 質問を投稿できること
        it "add a question" do
          question_params = FactoryGirl.attributes_for(:question)
          sign_in @user
          expect{
            post :create, params: { question: question_params }
          }.to change(@user.questions, :count).by(1)
        end
      end
      # 無効な属性値の場合
      context "with invalid attributes" do
        # 質問を投稿できないこと
        it "does not add a question" do
          question_params = FactoryGirl.attributes_for(:question, :invalid)
          sign_in @user
          expect{
            post :create, params: { question: question_params }
          }.to_not change(@user.questions, :count)
        end
      end
    end

    # 認可されていないユーザーとして
    context "as a not authenticated user" do
      # root_urlにリダイレクトすること
        it "redirects to sign in page" do
        @user = FactoryGirl.create(:user)
        other_user = FactoryGirl.create(:user)
        question_params = FactoryGirl.attributes_for(:question, user_id: other_user.id)
        sign_in @user
        post :create, params: { question: question_params }
        expect(response).to redirect_to root_url
      end
    end

    # ゲストとして
    context "as a guest" do
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        question_params = FactoryGirl.attributes_for(:question)
        post :create, params: { question: question_params }
        expect(response).to have_http_status "302"
      end

      # ログインページにリダイレクトすること
      it "redirects to sign in page" do
        question_params = FactoryGirl.attributes_for(:question)
        post :create, params: { question: question_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do

    before do
      @question = FactoryGirl.create(:question)
    end

    # 正常にレスポンスを返すこと
    it "responds successfully" do
      get :show, params: { id: @question.id }
      expect(response).to be_success
    end

    # 200レスポンスを返すこと
    it "returns a 200 response" do
      get :show, params: { id: @question.id }
      expect(response).to have_http_status "200"
    end
  end

  describe "#edit" do
    # 認証済みのユーザーとして
    context "as a authenticated user" do
      before do
        @user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question, user_id: @user.id)
      end
      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in @user
        get :edit, params: { id: @question.id }
        expect(response).to be_success
      end

      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in @user
        get :edit, params: { id: @question.id }
        expect(response).to have_http_status "200"
      end
    end

    # 認可されていないユーザーとして
    context "as a not authenticated user" do
      # root_urlにリダイレクトすること
      it "redirects to root url" do
        @user = FactoryGirl.create(:user)
        other_user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question, user_id: other_user.id)
        sign_in @user
        get :edit, params: { id: @question.id }
        expect(response).to redirect_to root_url
      end
    end

    # ゲストとして
    context "as a guest" do
      # ログインページにリダイレクトすること
      it "redirects to sign in page" do
        @question = FactoryGirl.create(:question)
        get :edit, params: { id: @question.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    # 認証済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question, user_id: @user.id)
      end
      # 投稿を編集できること
      it "update a question" do
        question_params = FactoryGirl.attributes_for(:question, title: "Edited title")
        sign_in @user
        patch :update, params: { id: @question.id, question: question_params }
        expect(@question.reload.title).to eq "Edited title"
      end
    end

    # 認可されていないユーザーとして
    context "as a not authenticated user" do
      # root_urlにリダイレクトすること
      it "redirects to root url" do
        @user = FactoryGirl.create(:user)
        other_user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question, user_id: other_user.id)
        question_params = FactoryGirl.attributes_for(:question)
        sign_in @user
        patch :update, params: { id: @question.id, question: question_params }
        expect(response).to redirect_to root_url
      end
    end

    # ゲストとして
    context "as a guest" do
      # ログインページにリダイレクトすること
      it "redirects to sign in page" do
        @question = FactoryGirl.create(:question)
        question_params = FactoryGirl.attributes_for(:question)
        patch :update, params: { id: @question.id, question: question_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    # 認可されたユーザーとして
    context "as an authenticated user" do
      before do
        @user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question, user_id: @user.id)
      end

      # 投稿を削除できること
      it "deletes a question" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @question.id }
        }.to change(@user.questions, :count).by(-1)
      end
    end

    # 認可されていないユーザーとして
    context "as a not authenticated user" do
      # root_urlにリダイレクトすること
      it "redirects to root url" do
        @user = FactoryGirl.create(:user)
        other_user = FactoryGirl.create(:user)
        @question = FactoryGirl.create(:question, user_id: other_user.id)
        sign_in @user
        delete :destroy, params: { id: @question.id }
        expect(response).to redirect_to root_url
      end
    end

    # ゲストとして
    context "as a guest" do
      # ログインページにリダイレクトすること
      it "redirects to sign in page" do
        @question = FactoryGirl.create(:question)
        delete :destroy, params: { id: @question.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
