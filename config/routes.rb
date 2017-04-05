Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get  '/users/fast', to: 'users/fast#show',               as: :user_fast
    put  '/users/fast', to: 'users/fast#quick_session',      as: :user_fast_session
    post '/users/fast', to: 'users/fast#quick_registration', as: :user_fast_registration
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Shopper::Engine, at: '/', as: 'shopper'

  resources :books, only: %i(show update)

  scope path: 'categories' do
    get '/',    to: 'categories#show', as: :categories
    get '/:id', to: 'categories#show', as: :category
  end

  namespace :settings do
    resource :address, only: %i(show update)
    resource :profile, only: %i(show update destroy), controller: 'profile'
  end
end
