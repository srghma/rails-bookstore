module CheckoutPage
  class ValidateStep < Rectify::Command
    def initialize(step)
      @stem = step
    end

    def call
      broadcast(:ok)
    end
  end
end
