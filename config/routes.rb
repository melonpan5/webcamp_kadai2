Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about'
  resources :users,only: [:index, :show, :create, :edit, :update, :destroy]
  resources :books,only: [ :index, :new, :show, :create, :edit, :update, :destroy ] do
  	resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

end