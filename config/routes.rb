Antwars::Application.routes.draw do
  resources :matches, only: [:show, :index]

  resources :bots, only: [:create, :show, :new]
  root :to => 'matches#index'
end
