Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: "home#dashboard", as: :authenticated_root
  end

  root to: 'home#index'

  resources :movies, only: [:new, :create, :index]
end
