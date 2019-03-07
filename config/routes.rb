Rails.application.routes.draw do
  resource :session, only: [:create, :destroy]
  resources :users, only: [:create]
  resources :notes, only: [:create, :index]
end
