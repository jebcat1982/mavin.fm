class UserController < ApplicationController
  respond_to :json

  def show
    respond_with @user = User.find_by_username(params[:username])
  end

  def liked
    @user = User.find_by_username(params[:username])
    respond_with @user.liked_tracks.find(:all, :select => "DISTINCT ON (track_id) * ", :order => 'track_id, ratings.created_at DESC')
  end

  def disliked
    @user = User.find_by_username(params[:username])
    respond_with @user.disliked_tracks
  end
end
