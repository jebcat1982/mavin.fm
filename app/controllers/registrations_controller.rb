class RegistrationsController < Devise::RegistrationsController
  skip_filter :require_no_authentication
  before_filter :check_if_registered, :only => [:new, :create]

  def new
    super
  end

  def create
    current_user.registered = true
    if current_user.update_attributes(params[:user])
      sign_in User, current_user, bypass: true
      redirect_to root_path
    else
      respond_with @resource = current_user
    end
  end
end
