Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get  '/users/fast',              to: 'users/fast#new',              as: :user_fast
    post '/users/fast/session',      to: 'users/fast#new_session',      as: :user_fast_session
    post '/users/fast/registration', to: 'users/fast#new_registration', as: :user_fast_registration
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :books, only: :show do
    member do
      post :add_to_cart
    end
  end

  scope path: 'categories' do
    get '/',    to: 'categories#show', as: :categories
    get '/:id', to: 'categories#show', as: :category
  end

  scope :cart do
    get    '/', to: 'cart#edit', as: :cart
    post   '/', to: 'cart#update', as: :update_cart
    post   '/book/:id', to: 'cart#add_product', as: :cart_add_product
    delete '/book/:id', to: 'cart#remove_product', as: :cart_remove_product
  end

  # resource :cart, only: [:show]
  resources :orders, only: [:index, :edit]

  resources :order_item, only: [:create, :update, :destroy]
  resources :checkout, only: [:show, :update]

  # resource :cart_item, controller: :order_item, only: [:create, :update, :destroy]
  # post   '/:class/:id', to: 'cart#add_product',    as: :cart_add_product
  # delete '/:class/:id', to: 'cart#remove_product', as: :cart_remove_product
end
