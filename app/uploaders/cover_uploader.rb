class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  process resize_to_limit: [300, -1]

  version :thumb do
    process resize_to_limit: [150, -1]
  end

  def default_url
    path = 'fallback/' + [version_name, 'cover_default.png'].compact.join('_')
    ActionController::Base.helpers.image_path path
  end
end
