class RegistrationsController < Devise::RegistrationsController
  skip_filter :require_no_authentication

  def new
    super
  end

  def create
    current_user.registered = true
    if current_user.update_attributes(params[:user])
      sign_in User, resource, bypass: true
      redirect_to root_path
    else
      respond_with @resource = current_user
    end
  end
end
