Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: "home#dashboard", as: :authenticated_root
  end

  root to: 'home#index'

  resources :movies do
    resources :show_timings, only: [:show] do
      resources :bookings, only: [:new, :create, :index]
    end
  end

  resources :bookings, only: :destroy
  get 'my_bookings', to: 'bookings#my_bookings'
end
