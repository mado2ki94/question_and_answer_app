Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, module: :users
  root 'static_pages#home'
  resources :users, :only => [:show]
  resources :questions
  resources :answers, :only => [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
