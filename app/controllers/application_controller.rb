class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :create_user

  def create_user
    if current_user.nil?
      tmp_name = "unregistered#{Time.now.to_i}#{rand(100)}"
      u = User.new(username: tmp_name, email: tmp_name, registered: false)
      u.save(validate: false)
      u.remember_me!
      sign_in(User, u)
    end
  end

  def check_if_registered
    if current_user.registered
      redirect_to root_path
    end
  end
end
