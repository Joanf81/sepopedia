class WebmastersController < UsersController
	before_action :check_webmaster!
	before_action :set_resource, only: [:show, :delete_user, :make_webmaster]

	def webmaster
		@user = current_user
		@users = User.all.where.not(id: @user.id).decorate 

		render :webmaster
	end

	def delete_user
		unless @resource.webmaster?
			if @resource.destroy
				flash[:notice] = "Usuario eliminado correctamente."
			else
				flash[:alert] = @resource.errors.messages.values.join(", ") + "."
			end

			redirect_to :webmaster
		end
	end

	def make_webmaster
		if !@resource.webmaster?
			if @resource.webmaster!
				flash[:notice] = "Privilegios de webmaster asignados correctamente."
			else
				flash[:alert] = @resource.errors.messages.values.join(", ") + "."
			end
		else
			flash[:alert] = "El usuario ya es webmaster."
		end

		redirect_to :webmaster
	end

	def renounce_webmaster
		@user = current_user.object

		if @user.user!
			flash[:notice] = "Has renunciado correctamente a tus privilegios como webmaster."
		else
			flash[:alert] = @resource.errors.messages.values.join(", ") + "."
		end

		redirect_to :root
	end


	private

	def check_webmaster!
		unless current_user.webmaster?
			flash[:alert] = "Es necesario tener privilegios de webmaster para acceder a esa sección."
			redirect_to :root
		end
	end

	def decorate_resource?
		false
	end
end
