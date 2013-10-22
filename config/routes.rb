Doorman::Application.routes.draw do
  get "welcome/index"

  root :to => 'welcome#index'
 
  get '/voice/incoming', to: "voice#incoming"

end
