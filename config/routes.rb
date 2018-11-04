Rails.application.routes.draw do
  devise_for :users

  constraints(subdomain: 'patwalls') do
    root "i/posts#index", as: 'subdomain_blog_index'
    get '/:post_id', to: 'i/posts#show', as: 'subdomain_blog_show'
  end

  constraints(host: 'patwalls.co') do
    root "i/posts#index", as: 'host_blog_index'
    get '/:post_id', to: 'i/posts#show', as: 'host_blog_show'
  end

  root 'welcome#index'

  resource :profile, only: [:show], controller: 'profile'
  resource :dashboard, only: [:show], controller: 'dashboard', :as => 'user_root'

  resources :posts do
    post :publish
    post :unpublish
  end

  resources :users, only: [:update]

  get '/google_drive_authorize' => 'google_drive#authorize', as: 'google_drive_authorize'
  get '/callback' => 'google_drive#callback', as: 'callback'
  get '/privacy_policy' => 'privacy_policy#show'
  get '/waitlist' => 'waitlist#show'

  get '/:username', to: 'i/posts#index', as: 'blog_index'
  get '/:username/:post_id', to: 'i/posts#show', as: 'blog_show'
end
