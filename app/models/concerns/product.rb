module Product
  extend ActiveSupport::Concern

  included do
    Bookstore::ProductClasses.register(self)

    has_many :order_items, as: :product, dependent: :destroy

    def product_type
      self.class.to_s.underscore
    end
  end
end
