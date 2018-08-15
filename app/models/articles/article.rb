module Articles
	class Article < ApplicationRecord

		has_many :article_editions
		has_many :users, through: :article_editions

		validates :article_editions, length: { minimum: 1 }

		attr_accessor :picture
		attr_accessor :content

		def article_owner
			article_editions.first.user
		end

		def is_article_owner? user
			article_owner == user
		end

		def last_edition
			article_editions.last
		end

		def picture
			last_edition.picture
		end

		def content
			last_edition.content
		end

		def last_modification_date
			last_edition.created_at
		end
	end
end