Rails.application.routes.draw do
  root 'users#index'
  resources :pitches, only: :index
  resources :quizes, only: :index
end
