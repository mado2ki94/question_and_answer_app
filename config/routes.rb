Rails.application.routes.draw do
  get 'responses/create'
  get 'responses/destroy'
  get 'users/show'
  devise_for :users, module: :users
  root 'static_pages#home'
  resources :users, :only => [:show]
  resources :questions
  resources :answers, :only => [:create, :destroy]
  resources :responses, :only => [:create, :destroy]
  patch 'resolutions', to: 'resolutions#close'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
