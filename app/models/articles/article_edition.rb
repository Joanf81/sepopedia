module Articles
	class ArticleEdition < ApplicationRecord

		belongs_to :user
		belongs_to :article

		validates :user, presence: true
		validates :article, presence: true

		mount_uploader :picture, ArticlePictureUploader
  	validates :picture, file_size: { less_than_or_equal_to: ::PictureUploader::MAX_SIZE, greater_than_or_equal_to: ::PictureUploader::MIN_SIZE }


  	def first_edition?
  		article.try(:article_editions).try(:first) == self
  	end

  	def characters_added
  		content.try(:size) || 0
  	end
	end
end