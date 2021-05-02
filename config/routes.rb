Rails.application.routes.draw do
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end
  
  devise_for :users
  root 'homes#top'
  get "/home/about" => "homes#about"
  resources :users, only: [:top, :show, :index, :edit, :update]

end