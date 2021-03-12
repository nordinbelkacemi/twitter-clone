Rails.application.routes.draw do
  root to: "pages#home", as: :home
  devise_for :users
end
