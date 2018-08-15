class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  MIN_SIZE = 1.byte
  MAX_SIZE = 10.megabytes

  process resize_to_fit: [600, 600]

  version :normal do
    process resize_to_fill: [300, 300]
  end

  version :icon do
    process resize_to_fill: [50, 50]
  end

  def store_dir
    "file_uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end

  def content_type_blacklist
    ['application/text', 'application/json']
  end

  def size_range
    MIN_SIZE..MAX_SIZE
  end
end
