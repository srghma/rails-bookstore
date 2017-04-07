class User < ApplicationRecord
  extend OmniauthAuthenticable
  extend FastAuthenticable

  acts_as_customer

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def to_s
    email
  end
end
