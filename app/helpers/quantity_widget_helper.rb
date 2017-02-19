module QuantityWidgetHelper
  def quantity_widget(order_item)
    content_tag :div, class: 'input-group general-position' do
      concat quantity_changer(:minus)
      concat quantity_input
      concat quantity_changer(:plus)
    end
  end

  private

  def quantity_input
    number_field_tag(
      :quantity,
      1,
      min: 1,
      class: 'form-control quantity-input',
      type: 'text'
    )
  end

  def quantity_changer(type)
    link_to '#', class: 'input-link' do
      content_tag :i, nil, class: "fa fa-#{type} line-height-40"
    end
  end
end
