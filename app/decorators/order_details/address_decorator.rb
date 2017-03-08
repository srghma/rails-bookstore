module OrderDetails
  class AddressDecorator < SimpleDelegator
    include ViewHelpers

    BR = '<br />'.html_safe.freeze

    def to_html
      full_name = "#{first_name} #{last_name}"
      middle = helpers.safe_join([street, city, country.name], BR)

      phone_label = I18n.t('simple_form.labels.address.phone')
      phone = helpers.safe_join([phone_label, __getobj__.phone], ' ')

      helpers.safe_join([full_name, middle, phone], BR)
    end
  end
end
