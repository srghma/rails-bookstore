Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
