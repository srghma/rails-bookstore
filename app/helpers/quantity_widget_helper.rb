module QuantityWidgetHelper
  def quantity_widget(*args, **kargs)
    builder = QuantityWidgetBuilder.new(*args, **kargs)
    builder.attach(self)
    builder.build
  end

  class QuantityWidgetBuilder
    def initialize(item, field_builder, valid: true)
      @item = item
      @field_builder = field_builder
      @valid = valid
    end

    def attach(context)
      @context = context
    end

    def build
      content_tag :div,
                  class: "input-group general-position #{error_class}",
                  data: { quantity: true } do
        concat quantity_changer(:minus)
        concat quantity_input
        concat quantity_changer(:plus)
      end
    end

    def quantity_input
      @field_builder.text_field(:quantity, class: 'form-control quantity-input')
    end

    def quantity_changer(type)
      link_to '#', class: 'input-link' do
        content_tag :i, nil, class: "fa fa-#{type} line-height-40"
      end
    end

    def error_class
      'has-error' unless @valid
    end

    def method_missing(method_name, *args, &block)
      if @context.respond_to?(method_name)
        @context.public_send(method_name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      @context.respond_to?(method_name, include_private)
    end
  end
end
