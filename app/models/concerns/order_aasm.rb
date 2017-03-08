module OrderAasm
  extend ActiveSupport::Concern
  included do
    include AASM

    enum state: %i(in_progress processing in_delivery delivered canceled)

    aasm column: :state, enum: true, whiny_transitions: false do
      state :in_progress, initial: true
      state :processing
      state :in_delivery
      state :delivered
      state :canceled

      event :place_order do
        transitions from: :in_progress, to: :processing
      end

      event :sent_to_client do
        transitions from: :processing, to: :in_delivery
      end

      event :end_delivery do
        transitions from: :in_delivery, to: :delivered
      end

      event :cancel do
        transitions from: [:processing, :in_delivery], to: :canceled
      end
    end
  end
end
