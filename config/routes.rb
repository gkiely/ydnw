Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resource :dashboard, only: [:show], controller: 'dashboard'
  resources :posts

  get '/:username/:post_id', to: 'i/posts#show'

  get '/google_drive_authorize' => 'google_drive#authorize', as: 'google_drive_authorize'
  get '/callback' => 'google_drive#callback', as: 'callback'
end
