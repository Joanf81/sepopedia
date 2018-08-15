class ArticlePictureUploader < PictureUploader
	def default_url(*args)
    ActionController::Base.helpers.asset_path("default_images/default_article_image.jpeg")
  end
end