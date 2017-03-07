module FastAuthenticable
  FAST_PROVIDER = 'fast'.freeze

  def from_fast_registration(sign_up_params)
    user = new(sign_up_params)
    user.provider = FAST_PROVIDER
    user.password = Devise.friendly_token[0, 20]
    user.save
    user
  end
end
