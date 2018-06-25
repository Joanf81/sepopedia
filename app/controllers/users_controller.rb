class UsersController < BaseController
	skip_before_action :authenticate_user!, :only => [:show]

	def my_profile
		@resource = current_user
		render :show
	end

	private

	def resource_type
		User
	end

	def resource_not_found_msg
		"El usuario que intentas buscar no existe, intentelo de nuevo."
	end

	def decorate_resource?
		true
	end
end
