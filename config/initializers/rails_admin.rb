RailsAdmin.config do |config|
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  config.parent_controller = '::ApplicationController'

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    dropzone do
      only Book
    end
  end

  # Look firstly for #to_s as label
  config.label_methods = [:to_s].concat(config.label_methods)

  config.excluded_models << 'Authorship'
  config.excluded_models << 'OrderItem'

  config.model 'User' do
    exclude_fields :reset_password_sent_at,
                   :remember_created_at,
                   :password_confirmation
  end

  config.model 'Book' do
  end
  # config.model 'Order' do
  #   nested do
  #     field :order_item
  #   end
  # end
end
