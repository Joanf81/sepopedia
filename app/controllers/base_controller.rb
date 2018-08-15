class BaseController < ApplicationController
	before_action :set_resource, only: [:show, :edit, :update, :destroy]
	before_action :build_resource, only: [:new, :create]
	before_action :decorate_resource, only: [:new, :show, :edit]

	private

	def set_resource
		unless @resource = resource_type.find_by(id: params[:id])
			flash[:alert] = resource_not_found_msg
			redirect_to :root
		end
	end

	def build_resource
		@resource = resource_type.new
	end

	def resource_type
		raise NotImplementedError
	end

	def resource_not_found_msg
		"El recurso que intentas buscar no existe."
	end

	def decorate_resource
		@resource = @resource.try(:decorate) if decorate_resource?
	end

	def decorate_resource?
		raise NotImplementedError
	end

	def set_errors_based_on_resource
		flash[:alert] = @resource.errors.messages.values.join(", ") + "."
	end
end
