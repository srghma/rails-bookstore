class CoverUploader < BaseUploader
  process resize_to_limit: [300, -1]

  version :thumb do
    process resize_to_limit: [150, -1]
  end

  def default_url
    path = 'fallback/' + [version_name, 'cover_default.png'].compact.join('_')
    ActionController::Base.helpers.image_path path
  end
end
