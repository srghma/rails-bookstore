module OmniauthAuthenticable
  def from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    user = find_by(email: auth.info.email)
    if user
      update(user.id, provider: auth.provider, uid: auth.uid)
    else
      create do |u|
        u.email = auth.info.email
        u.first_name = auth.info.first_name
        u.last_name = auth.info.last_name
        u.password = Devise.friendly_token[0, 20]
      end
    end
  end
end
