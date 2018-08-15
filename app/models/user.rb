class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable

  mount_uploader :profile_picture, ProfilePictureUploader
  enum role: [:user, :webmaster]

  has_many :article_editions, class_name: "Articles::ArticleEdition"
  has_many :articles, through: :article_editions, class_name: "Articles::Article"

  after_initialize :set_default_role, :if => :new_record?

  validates :profile_picture, file_size: { less_than_or_equal_to: ::PictureUploader::MAX_SIZE, greater_than_or_equal_to: ::PictureUploader::MIN_SIZE }

  SING_UP_PARAMS = [:email, :password, :password_confirmation]
  SING_IN_PARAMS = [:email, :password, :password_confirmation]
  ACCOUNT_UPDATE_PARAMS = [:email, :password, :password_confirmation, :current_password, :user_name, :first_name, :second_name, :tlf, :content, :profile_picture]

  PUNTUATION_FOR_PROFILE_COMPLETED = {
  	email: 25,
  	first_name: 15,
  	second_name: 10,
  	profile_picture: 25,
  	content: 25
  }	

  def created_articles
    articles.select do |article|
      article.article_editions.first.user == self
    end
  end

  def edited_articles  # It does't include the articles that are only created by the user
    article_editions.select{ |edition| !edition.first_edition? }.map{ |edition| edition.try(:article) }.uniq
  end

  def has_created_any_article?
    created_articles.any?
  end

  def has_edited_any_article?
    edited_articles.any?
  end

  def percentage_completed_profile
  	PUNTUATION_FOR_PROFILE_COMPLETED.inject(0) do |percent, puntuation| 
      send("#{puntuation.first}?") ? (percent + puntuation.second) : percent 
    end
  end

  def profile_completed?
  	percentage_completed_profile >= 100 ? true : false
  end


  private

  def set_default_role
	self.role ||= :user
  end
end
