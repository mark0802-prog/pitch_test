Rails.application.routes.draw do
  root 'users#index'
  resources :pitches, only: :index
end
