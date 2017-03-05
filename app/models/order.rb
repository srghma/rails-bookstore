class Order < ApplicationRecord
  before_create :generate_number

  belongs_to :user,     optional: true
  belongs_to :delivery, optional: true

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :coupon, dependent: :nullify
  has_one :credit_card, dependent: :destroy

  has_one :billing_address,  as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  include AASM

  enum state: %i(in_progress processing in_delivery delivered canceled)

  aasm column: :state, enum: true, whiny_transitions: false do
    state :in_progress, initial: true
    state :processing
    state :in_delivery
    state :delivered
    state :canceled

    event :place_order do
      transitions from: :in_progress, to: :processing
    end

    event :sent_to_client do
      transitions from: :processing, to: :in_delivery
    end

    event :end_delivery do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: [:processing, :in_delivery], to: :canceled
    end
  end

  def create_or_increment_product(id, quantity = 1)
    item = order_items.find_or_initialize_by(book_id: id)
    item.quantity = item.persisted? ? item.quantity + quantity.to_i : quantity
    item.save ? item : false
  end

  def create_or_update_product(id, quantity = 1)
    item = order_items.find_or_initialize_by(book_id: id)
    item.quantity = quantity
    item.save ? item : false
  end

  def generate_number
    self.number = '#R'.ljust(10, rand.to_s[2..-1])
  end

  def to_s
    "Order #{id}"
  end
end
