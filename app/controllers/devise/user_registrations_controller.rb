class Devise::UserRegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(User::SING_UP_PARAMS)
  end

  def account_update_params
    params.require(:user).permit(User::SING_IN_PARAMS)
  end
end