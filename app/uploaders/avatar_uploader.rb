class AvatarUploader < BaseImageUploader
  process resize_to_fill: [300, 300]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def default_url
    '/images/fallback/avatar_default.png'
  end
end
