class ImageUploader < CarrierWave::Uploader::Base
  # Storage
  storage :file

  # Dir
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Mini Magick
  include CarrierWave::MiniMagick

  # Thumbnail
  version :thumb do
    process resize_to_fill: [200,200]
  end
end