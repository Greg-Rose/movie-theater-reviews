Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  resources :movie_theaters, except: [:destroy] do
    resources :reviews, only: [:new, :create]
  end

  root 'movie_theaters#index'
end
