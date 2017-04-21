Rails.application.routes.draw do
  devise_for :users
  resources :movie_theaters, only: [:index]

  root 'movie_theaters#index'
end
