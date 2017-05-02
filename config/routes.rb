Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }

  resources :movie_theaters, except: [:destroy] do
    resources :reviews, except: [:index, :show, :destroy]
  end

  namespace :admin do
    resources :users, only: [:index, :show]
  end

  root 'movie_theaters#index'
end
