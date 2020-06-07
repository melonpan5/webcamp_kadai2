Rails.application.routes.draw do
  devise_for :users,:controllers => {
    :registrations => 'users/registrations'
  }

  resources :users,only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
     get :follows, :followers
    end
  end
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :relationships,only: [:create, :destroy]

  resources :books,only: [ :index, :new, :show, :create, :edit, :update, :destroy ] do
  	resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
 
  get'search' =>'searches#index'
  root 'home#top'
  get 'home/about' => 'home#about'
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

  #post '/dreams/:dream_id/likes' => "likes#create"
  #delete '/dreams/:dream_id/likes' => "likes#destroy"
  
end