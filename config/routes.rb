Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resource :dashboard, only: [:show], controller: 'dashboard'
  resource :profile, only: [:show], controller: 'profile'

  resources :posts

  resources :users, only: [:update]

  get '/:username', to: 'i/posts#index'
  get '/:username/:post_id', to: 'i/posts#show'

  get '/google_drive_authorize' => 'google_drive#authorize', as: 'google_drive_authorize'
  get '/callback' => 'google_drive#callback', as: 'callback'
end
