class Ability
  include CanCan::Ability

  def initialize(user, order = nil)
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :read, :update, :destroy, to: :rud

    if user
      if user.is_admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, :all
      else
        can :crud, [::Shopper::BillingAddress, ::Shopper::ShippingAddress]
        can :rud, User, id: user.id
        can :read, ::Shopper::Order, customer_id: user.id
      end
    end

    can :read, Book
    can :read, Category
    can :read, Author
    can [:update, :destroy], ::Shopper::OrderItem do |item|
      order && item.order == order
    end
  end
end
