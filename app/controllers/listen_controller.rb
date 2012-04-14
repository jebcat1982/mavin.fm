class ListenController < ApplicationController
  before_filter :create_session, :establish_session

  def index
  end

  def likes
    if current_user
      Like.create(user_id: current_user.id, track_id: params[:track_id])
    else
      Like.create(session_id: current_session, track_id: params[:track_id])
    end

    playlist = Playlist.find(params[:playlist_id])
    playlist.like(params[:track_id])

    render :nothing => true
  end

  def dislikes
    if current_user
      Dislike.create(user_id: current_user.id, track_id: params[:track_id])
    else
      Dislike.create(session_id: current_session, track_id: params[:track_id])
    end

    playlist = Playlist.find(params[:playlist_id])
    playlist.dislike(params[:track_id])

    render :nothing => true
  end
end
