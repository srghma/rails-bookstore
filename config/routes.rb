Rails.application.routes.draw do
  root to: 'home#index'

  resources :books
  resources :categories
  devise_for :users, controllers: { sessions: 'users/sessions' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
