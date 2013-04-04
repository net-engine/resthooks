# Monkey patched until rails 4 and devise for rails 4 is released.

class Users::RegistrationsController < Devise::RegistrationsController

  private

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  protected

  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end
end
