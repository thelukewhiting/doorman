Doorman::Application.routes.draw do

  get "dashboard/index"

  devise_for :users

  get 'welcome/index'

  root :to => 'welcome#index'

  get '/dashboard', to: 'dashboard#index'

  get '/voice/incoming', to: 'voice#incoming'

  resources :settings

  post 'settings/create_twilio_account', to: 'settings#create_twilio_account'
  post 'settings/fetch_twilio_number', to: 'settings#fetch_twilio_number'
  post 'settings/buy_twilio_number', to: 'settings#buy_twilio_number'


  match '*path' => redirect('/')

end
