module OrderDetails
  class OrderDecorator < SimpleDelegator
    include CallerAttachable

    STARS = '** ** ** '.freeze
    BR = '<br />'.html_safe.freeze

    def initialize(order, edit_link:)
      @edit_link = edit_link
      super order
    end

    def edit_link?
      @edit_link
    end

    def edit_link(step)
      link_to t('checkout.edit'), @caller.wizard_path(step), class: 'general-edit'
    end

    def billing_address
      @billing_address ||= OrderDetails::AddressDecorator.new(__getobj__.billing_address).to_html
    end

    def shipping_address
      return billing_address if __getobj__.use_billing?
      OrderDetails::AddressDecorator.new(__getobj__.shipping_address).to_html
    end

    def shipments
      delivery = __getobj__.delivery
      price = number_to_currency(delivery.price)
      safe_join([price, delivery.title], BR)
    end

    def payment
      card = __getobj__.credit_card
      number = STARS + card.number.last(4)
      date = card.expiration_date.strftime '%m/%Y'
      safe_join [number, date], BR
    end
  end
end
