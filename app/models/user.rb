class User < ApplicationRecord
  extend OmniauthAuthenticable
  extend FastAuthenticable

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :orders, dependent: :destroy

  has_one :billing_address,  as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  attr_accessor :skip_email_uniqueness_validation

  def to_s
    email
  end
end
