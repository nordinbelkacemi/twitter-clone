Rails.application.routes.draw do
  devise_for :users

  resources :posts, except: :show

  resources :users, only: [] do
    resources :posts, only: :index
  end

  resources :posts, only: [] do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]  
    resources :likes, only: [:create]
  end

  resources :likes, only: [:destroy]

  resources :comments, only: [] do
    resources :likes, only: [:create]
  end

  root to: "pages#home", as: :home
end
