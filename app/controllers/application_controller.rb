class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	protect_from_forgery with: :exception

	before_action :set_resource, only: [:show]

	protected

	def current_user
	    super.try(:decorate) || super
	end

	private

	def set_resource
		unless @resource = resource_type.find_by(id: params[:id])
			flash[:alert] = resource_not_found_msg
			redirect_to :root
		end
		decorate_resource if decorate_resource?
	end

	def resource_type
		raise NotImplementedError
	end

	def resource_not_found_msg
		"El recurso que intentas buscar no existe, intentelo de nuevo."
	end

	def decorate_resource
		@resource = @resource.try(:decorate)
	end

	def decorate_resource?
		raise NotImplementedError
	end
end
