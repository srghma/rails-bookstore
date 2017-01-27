class User < ApplicationRecord
  include ActiveModel::Validations

  before_validation :downcase_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :email, presence: true, email: true, uniqueness: true

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    user = find_by(email: auth.info.email)
    if user
      update(user.id, provider: auth.provider, uid: auth.uid)
    else
      create do |u|
        u.email = auth.info.email
        u.password = Devise.friendly_token[0, 20]
      end
    end
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
