class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :coupon, dependent: :nullify
  has_one :billing_address,  as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  include AASM

  enum aasm_state: %i(in_progress processing in_delivery delivered canceled)

  aasm whiny_transitions: false do
    state :in_progress, initial: true
    state :processing
    state :in_delivery
    state :delivered
    state :canceled

    event :queue do
      transitions from: :in_progress, to: :processing, guard: :ready_for_processing?
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

  def ready_for_processing?
    [billing_address, shipping_address].all?(&:present?) && order_items.any?
  end

  def to_s
    "Order #{id}"
  end
end
