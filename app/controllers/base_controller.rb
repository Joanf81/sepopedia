class BaseController < ApplicationController
	before_action :set_resource, only: [:show]

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
