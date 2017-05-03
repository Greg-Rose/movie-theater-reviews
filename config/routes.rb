Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }

  resources :movie_theaters do
    resources :reviews, except: [:index, :show]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
  end

  root 'movie_theaters#index'
end
