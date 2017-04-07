class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process convert: 'jpg'

  if Rails.env.production?
    storage :dropbox
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
