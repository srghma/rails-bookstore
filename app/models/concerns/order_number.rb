module OrderNumber
  extend ActiveSupport::Concern

  included do
    before_create :generate_number

    def generate_number
      self.number = '#R'.ljust(10, rand.to_s[2..-1])
    end
  end
end
