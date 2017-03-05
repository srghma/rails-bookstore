class PasswordForm < Rectify::Form
  mimic User

  attribute :old_password, String
  attribute :new_password, String
  attribute :new_password_confirmation, String

  validates :old_password,
            presence: true

  validates :new_password,
            presence: true,
            confirmation: true,
            length: { within: Devise.password_length }

  # validate :old_password_correctness

  # def old_password_correctness
  #   require 'pry'; ::Kernel.binding.pry;
  #   errors.add(:old_password, 'is invalid') unless context.user.password == old_password
  # end
end
