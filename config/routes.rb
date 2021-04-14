Rails.application.routes.draw do
  devise_for :users

  resources :posts, except: :show

  resources :users, only: [] do
    resources :posts, only: :index
  end

  resources :posts, only: [] do
    resources :comments, only: [:new, :create, :index]
    resources :likes, only: [:create]
  end

  resources :comments, only: [:destroy]
  resources :likes, only: [:destroy]

  resources :comments, only: [] do
    resources :likes, only: [:create]
  end

  root to: "posts#index", as: :home
end
