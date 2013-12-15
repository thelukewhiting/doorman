Doorman::Application.routes.draw do

  get "dashboard/index"

  devise_for :users

  get 'welcome/index'

  root :to => 'welcome#index'

  get '/dashboard', to: 'dashboard#index'

  get '/voice/incoming', to: 'voice#incoming'

  get '/settings/create_twilio_account', to: 'settings#create_twilio_account'
  get '/settings/fetch_twilio_number', to: 'settings#fetch_twilio_number'
  get '/settings/buy_twilio_number', to: 'settings#buy_twilio_number'
  get '/settings/test_settings', to: 'settings#test_settings'
  get '/settings/start_timer', to: 'settings#start_timer'
  get '/settings/update_mode', to: 'settings#update_mode'

  post '/voice/settings_test', to: 'voice#settings_test'


  resources :settings

  match '*path' => redirect('/')

end
