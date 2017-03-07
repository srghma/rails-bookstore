module CheckoutPage
  class ConfirmStepPresenter < Rectify::Presenter
    STARS = '** ** ** '.freeze
    BR = '<br />'.html_safe.freeze

    def billing_address
      @billing_address ||= CheckoutPage::AddressDecorator
                           .new(current_order.billing_address)
                           .to_html
    end

    def shipping_address
      if current_order.use_billing?
        billing_address
      else
        CheckoutPage::AddressDecorator
          .new(current_order.shipping_address)
          .to_html
      end
    end

    def shipments
      delivery = current_order.delivery
      price = number_to_currency(delivery.price)
      safe_join([price, delivery.title], BR)
    end

    def payment
      card = current_order.credit_card
      number = STARS + card.number.last(4)
      date = card.expiration_date.strftime '%m/%Y'
      safe_join [number, date], BR
    end

    def items
      @items ||= CheckoutPage::ItemDecorator
                    .for_collection(current_order.order_items)
    end

    def edit_link(step)
      link_to t('checkout.edit'), wizard_path(step), class: 'general-edit'
    end
  end
end
