class Devise::UserRegistrationsController < Devise::RegistrationsController

	def update
	    change_password = params[:user][:password].blank? ? false : true

	    unless change_password
	      	params[:user].delete(:password)
	      	params[:user].delete(:password_confirmation)
	      	params[:user].delete(:current_password)
	    end

	    @user = User.find(current_user.id)
	    update_action = change_password ? :update_with_password : :update_without_password

	    decorate_user

	    if @user.send(update_action, account_update_params)
	    	set_flash_message :notice, :updated
	      	sign_in @user, :bypass => true
	      	redirect_to after_update_path_for(@user)
	    else
	    	flash[:alert] = @user.errors.messages.values.join(", ") + "."
	      	render "edit"
	    end
    end


	protected

	def after_update_path_for(resource)
      edit_user_registration_path
    end


  	private

  	def sign_up_params
    	params.require(:user).permit(User::SING_UP_PARAMS)
  	end

  	def account_update_params
    	params.require(:user).permit(User::ACCOUNT_UPDATE_PARAMS)
  	end

  	def decorate_user
  		@user = @user.try(:decorate) unless @user.try(:decorated?)
  	end
end