Rails.application.routes.draw do
  resources :books
  resources :categories
  root to: 'home#index'

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
