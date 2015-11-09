class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def account_update_params
    params.require(:user).permit(:email, :address1, :address2, :picture, :first_name, :last_name, :description)
  end
end
