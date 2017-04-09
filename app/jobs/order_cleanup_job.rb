class OrderCleanupJob < ApplicationJob
  queue_as :low_priority
  RUN_EVERY = 1.day

  after_perform do
    self.class.perform_later(wait: RUN_EVERY)
  end

  def perform
    Shopper::Order.where(customer_id: nil).destroy_all
  end
end
