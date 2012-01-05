CarrotSns::Application.routes.draw do
  resources :users
  resource :session
  resources :top
  
  root :to => 'top#index'
end
