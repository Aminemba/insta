Rails.application.routes.draw do
  root 'users#new'

  resources :sessions,only: [:new , :create, :destroy]
  get "/sessions/:id", to: "sessions#destroy"
  post "/sessions/new", to: "users#index"

  resources :users

  resources :posts ,only: [:new ,:show , :update , :confirm, :edit, :index, :create, :destroy] do
  get "/post/:id", to: "post#destroy"
    collection do
      post :confirm
    end
    resources :likes, module: :posts
    resources :comments, only: [:create, :destroy] do
    resources :likes, module: :comments
      end
    end
end
