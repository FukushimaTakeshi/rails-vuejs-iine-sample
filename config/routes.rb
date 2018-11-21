Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts, only: [:index]
  
  namespace :api, { format: 'json' } do
    resources :likes, only: [:index, :create, :destroy]
  end
end
