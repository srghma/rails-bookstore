module CheckoutPage
  class ConfirmStepPresenter < Rectify::Presenter
    BR = '<br />'.html_safe.freeze
    STARS = '** ** ** '.freeze

    def billing_address
      @billing_address ||= address(:billing)
    end

    def shipping_address
      current_order.use_billing? ? billing_address : address(:shipping)
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

    def products
      @products ||= CheckoutPage::ProductDecorator
                    .for_collection(current_order.order_items)
    end

    def edit_link(step)
      link_to t('checkout.edit'), wizard_path(step), class: 'general-edit'
    end

    private

    def address(type)
      address = current_order.send("#{type}_address")

      full_name = attributes(%i(first_name last_name), address)
      middle = attributes(%i(street city), address, BR)
      country = address.country.name

      phone_label = t('simple_form.labels.address.phone')
      phone = safe_join([phone_label, address.phone], ' ')

      safe_join([full_name, middle, country, phone], BR)
    end

    def attributes(attrs, target, joiner = ' ')
      attrs.map! { |name| target.send(name) }
      safe_join(attrs, joiner)
    end
  end
end
