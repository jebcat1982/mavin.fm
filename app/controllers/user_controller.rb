class UserController < ApplicationController
  respond_to :json

  def show
    respond_with @user = User.find_by_username(params[:username])
  end
end
