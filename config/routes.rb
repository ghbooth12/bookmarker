Rails.application.routes.draw do
  post :incoming, to: 'incoming#create'

  resources :topics

  resources :topics, only: [] do
    resources :bookmarks, except: [:index, :show]
  end

  resources :bookmarks, only: [] do
    resources :likes, only: [:index, :create, :destroy]
  end

  devise_for :users
  resources :users, only: [:show]
  
  root 'welcome#index'
end
