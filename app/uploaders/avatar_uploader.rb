class AvatarUploader < ImageUploader
  process resize_to_fill: [300, 300]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def default_url
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    '/images/fallback/' + [version_name, 'default.png'].compact.join('_')
  end
end
