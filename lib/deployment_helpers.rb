module DeploymentHelpers
  module_function

  def development_create_order
    delivery = Delivery.first
    country = Country.first

    order = FactoryGirl.create :order,
                               :with_credit_card,
                               delivery: delivery

    FactoryGirl.create :billing_address,
                       country: country,
                       addressable: order

    FactoryGirl.create :shipping_address,
                       country: country,
                       addressable: order
    order
  end
end
