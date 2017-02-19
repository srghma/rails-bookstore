Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :books, only: :show

  scope path: 'categories' do
    get '/',    to: 'categories#show', as: :categories
    get '/:id', to: 'categories#show', as: :category
  end

  resources :orders, only: :index

  scope :cart do
    get '/', to: 'cart#show', as: :cart
    post   '/:model_name/:id', to: 'cart#add_product', as: :cart_add_product
    delete '/:model_name/:id', to: 'cart#remove_product', as: :cart_remove_product
  end

  resources :checkout, only: [:show, :update]
end
