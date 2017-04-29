Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: :registrations }
  resources :movie_theaters, except: [:destroy] do
    resources :reviews, except: [:index, :show, :destroy]
  end

  root 'movie_theaters#index'
end
