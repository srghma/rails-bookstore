class EmailForm < Rectify::Form
  mimic User

  attribute :email, String

  validates :email,
            presence: true,
            format: { with: Devise.email_regexp }

  validate :email_uniqueness

  def email_uniqueness
    errors.add(:email, 'is already taken') if User.exists?(email: email)
  end
end
