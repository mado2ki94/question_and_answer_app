Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  get 'likes/create'
  get 'likes/destroy'
  get 'responses/create'
  get 'responses/destroy'
  get 'users/show'
  devise_for :users, module: :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#home'
  resources :users, only: [:show] do
    member do
      get :likes
    end
  end
  resources :questions
  resources :answers, only: [:create, :destroy]
  resources :responses, only: [:create, :destroy]
  # patch 'resolutions', to: 'resolutions#close'
  match '/close', to: 'resolutions#close', via: 'patch'
  resources :likes, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :best_answers, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
