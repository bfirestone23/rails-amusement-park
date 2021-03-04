Rails.application.routes.draw do
  resources :attractions
  resources :users

  post '/rides', to: 'rides#create'

  get '/signin', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  root 'application#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
