Rails.application.routes.draw do
  resources :books
  devise_for :users
  root 'homes#top'
  get "about" => "homes#about"
  resources :users, only: [:top, :show, :index, :edit, :update]

end
