Rails.application.routes.draw do
  post :incoming, to: 'incoming#create'

  resources :topics

  resources :topics, only: [] do
    resources :bookmarks, except: [:index, :show]
  end

  devise_for :users
  root 'welcome#index'
end
