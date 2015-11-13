class RegistrationsController < Devise::RegistrationsController

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def account_update_params
    params.require(:user).permit(:email, :address1, :address2, :picture, :first_name, :last_name, :description)
  end

  def after_sign_up_path_for(resource)
     edit_user_registration_path(resource)
  end

end
