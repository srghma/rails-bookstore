Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :books, only: :show

  scope path: 'categories' do
    get '/',    to: 'categories#show', as: 'categories'
    get '/:id', to: 'categories#show', as: 'category'
  end
end
