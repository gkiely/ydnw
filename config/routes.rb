Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resource :dashboard, only: [:show], controller: 'dashboard'
  resources :posts
end
