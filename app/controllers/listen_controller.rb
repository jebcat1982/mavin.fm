class ListenController < ApplicationController
  before_filter :create_session, :establish_session

  def index
    @likes = Like.order('created_at DESC').limit(5)
  end

  def likes
    if current_user
      check = Like.where(user_id: current_user.id, track_id: params[:track_id]).first
      Like.create(user_id: current_user.id, track_id: params[:track_id])
    else
      check = Like.where(session_id: current_session, track_id: params[:track_id]).first
      Like.create(session_id: current_session, track_id: params[:track_id])
    end

    if check.nil?
      playlist = Playlist.find(params[:playlist_id])
      playlist.like(params[:track_id])
    end

    render :nothing => true
  end

  def dislikes
    if current_user
      check = Dislike.where(user_id: current_user.id, track_id: params[:track_id])
      Dislike.create(user_id: current_user.id, track_id: params[:track_id])
    else
      check = Dislike.where(session_id: current_session, track_id: params[:track_id])
      Dislike.create(session_id: current_session, track_id: params[:track_id])
    end

    if check.nil?
      playlist = Playlist.find(params[:playlist_id])
      playlist.dislike(params[:track_id])
    end

    render :nothing => true
  end
end
