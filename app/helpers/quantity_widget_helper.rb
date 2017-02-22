module QuantityWidgetHelper
  def quantity_widget(item, field_builder)
    content_tag :div, class: 'input-group general-position' do
      concat quantity_changer(:minus)
      concat quantity_input(field_builder)
      concat quantity_changer(:plus)
    end
  end

  private

  def quantity_input(field_builder)
    field_builder.text_field(:quantity, class: 'form-control quantity-input')
  end

  def quantity_changer(type)
    link_to '#', class: 'input-link' do
      content_tag :i, nil, class: "fa fa-#{type} line-height-40"
    end
  end
end
