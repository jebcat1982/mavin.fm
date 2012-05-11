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

  helper_method :current_session

  def create_session
    unless cookies[:restore_session]
      cookies[:restore_session] = { :value => (Digest::SHA2.new << Time.now.to_s).to_s, :expires => Time.now + 1.year.to_i }
    end
  end

  def establish_session
    unless session[:current]
      session[:current] = current_user || cookies[:restore_session] 
    end
  end

  def current_session
    session[:current]
  end
end
