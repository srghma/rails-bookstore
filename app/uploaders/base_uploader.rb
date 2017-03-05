class BaseUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  if Rails.env.production?
    include CarrierWave::MiniMagick
  else
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end
end
