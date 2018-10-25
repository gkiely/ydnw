Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resource :profile, only: [:show], controller: 'profile'
  resource :dashboard, only: [:show], controller: 'dashboard', :as => 'user_root'

  resources :posts

  resources :users, only: [:update]

  get '/google_drive_authorize' => 'google_drive#authorize', as: 'google_drive_authorize'
  get '/callback' => 'google_drive#callback', as: 'callback'
  get '/privacy_policy' => 'privacy_policy#show'
  get '/waitlist' => 'waitlist#show'

  get '/:username', to: 'i/posts#index'
  get '/:username/:post_id', to: 'i/posts#show'
end
