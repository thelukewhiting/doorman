Doorman::Application.routes.draw do
  get "welcome/index"

  root :to => 'welcome#index'
 
  get '/twilios/incoming', to: "twilios#incoming"

end
