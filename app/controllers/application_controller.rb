class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	protect_from_forgery with: :exception


	protected

	def current_user
	    super.try(:decorate) || super
	end
end