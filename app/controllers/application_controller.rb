class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_session

  def create_session
    unless cookies[:restore_session]
      cookies[:restore_session] = (Digest::SHA2.new << Time.now.to_s).to_s
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
