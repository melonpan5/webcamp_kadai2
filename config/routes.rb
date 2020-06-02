Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about'
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  resources :users,only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
     get :follows, :followers
    end
  end
  resources :relationships,only: [:create, :destroy]

  resources :books,only: [ :index, :new, :show, :create, :edit, :update, :destroy ] do
  	resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

	
end