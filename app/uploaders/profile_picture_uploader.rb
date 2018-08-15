class ProfilePictureUploader < PictureUploader
	def default_url(*args)
    ActionController::Base.helpers.asset_path("default_images/default_profile_image.png")
  end
end