Rails.application.routes.draw do

  root :to => 'users#index'

  resources :users, only: [:index] do
    resource :prescription, only: [:create]
  end
  get 'login', to: 'sessions#set_user'
  resource :inbox
  resource :outbox
  resources :messages do
    resource :reply
  end
end
