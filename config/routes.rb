Rails.application.routes.draw do
  root 'homes#top'
  get "/home/about" => "homes#about"
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
  
  resources :users, only: [:top, :show, :index, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end
  
  get "search" => "searches#search"
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

end