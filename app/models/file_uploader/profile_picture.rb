class FileUploader::Picture < FileUploader::Asset
  mount_uploader :data, PictureUploader, mount_on: :data_file_name
  validates :data, file_size: { maximum: 5.megabytes.to_i }

  def thumb_url
    url(:thumb)
  end
end