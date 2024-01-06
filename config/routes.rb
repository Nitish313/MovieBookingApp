Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: "home#dashboard", as: :authenticated_root
  end

  root to: 'home#index'

  resources :movies, only: [:new, :create, :index, :show, :destroy] do
    resources :show_timings, only: [:show] do
      resources :bookings, only: [:new, :create, :index, :destroy]
    end
  end
end
