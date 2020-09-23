Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :pitches, only: :index
  resources :quizes, only: [:index, :update]
end
