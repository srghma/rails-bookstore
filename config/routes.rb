Rails.application.routes.draw do
  root to: 'home#index'

  resources :books
  resources :categories
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
