class User < ApplicationRecord

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

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable
  
  mount_uploader :profile_picture, PictureUploader
  validates :profile_picture, file_size: { less_than_or_equal_to: ::PictureUploader::MAX_SIZE, greater_than_or_equal_to: ::PictureUploader::MIN_SIZE }

  def percentage_completed_profile
  	PUNTUATION_FOR_PROFILE_COMPLETED.inject(0){ |percent, puntuation| send("#{puntuation.first}?") ? percent + puntuation.second : percent }
  end

  def profile_completed?
  	percentage_completed_profile >= 100 ? true : false
  end
end
