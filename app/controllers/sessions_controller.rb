class SessionsController < Devise::SessionsController
  skip_filter :require_no_authentication
  before_filter :check_if_registered, :only => [:new, :create]

  def new
    super
  end

  def create
    # Sign the unregistered user out
    user = current_user
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(current_user))

    # Try to sign the user in
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
end
