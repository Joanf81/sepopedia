class User < ApplicationRecord

  SING_UP_PARAMS = [:email, :password, :password_confirmation]
  SING_IN_PARAMS = [:email, :password, :password_confirmation]

  # Include default devise modules. Others available are:
  # :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable
end
