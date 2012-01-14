CarrotSns::Application.routes.draw do
  resources :users
  resource :session
  resources :top do
    collection do
      post :change_locale
    end
  end
  
  root :to => 'top#index'
end
