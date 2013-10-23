Doorman::Application.routes.draw do
  
  devise_for :users

  get "welcome/index"

  root :to => 'welcome#index'
 
  get '/voice/incoming', to: "voice#incoming"

  resources :settings
  
end
