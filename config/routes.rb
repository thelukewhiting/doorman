Doorman::Application.routes.draw do
  
  get "dashboard/index"

  devise_for :users

  get 'welcome/index'

  root :to => 'welcome#index'

  get '/dashboard', to: 'dashboard#index'

  get '/voice/incoming', to: 'voice#incoming'

  resources :settings
  
end
