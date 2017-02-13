module SimpleForm
  module Components
    module Bookstore
      extend ActiveSupport::Concern
      include ActionView::Helpers::TagHelper
      include LabelInput

      def bookstore_checkbox(wrapper_options = nil)
        @bookstore_checkbox ||= begin
          icon = content_tag(:span,
                             content_tag(:i, nil, class: 'fa fa-check'),
                             class: 'checkbox-icon')
          checkbox_options = wrapper_options.merge(hidden: true,
                                                   class: 'checkbox-input')
          checkbox = build_check_box_without_hidden_field(checkbox_options)
          checkbox + icon
        end
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Bookstore)
