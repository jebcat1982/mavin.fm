class RatingsController < ApplicationController
  def rate
    liked = params[:liked] == "true" ? true : false

    if current_user
      rating = Rating.where(user_id: current_user.id, track_id: params[:track_id], playlist_id: params[:playlist_id]).first
    else
      rating = Rating.where(session_id: current_session, track_id: params[:track_id], playlist_id: params[:playlist_id]).first
    end

    if rating.nil?
      rating = Rating.new(track_id: params[:track_id], playlist_id: params[:playlist_id], liked: liked, time: params[:time], percentage: params[:percentage])
      if current_user
        rating.user_id = current_user
      else
        rating.session_id = current_session
      end
      rating.save

      playlist = Playlist.find(params[:playlist_id])
      if liked
        playlist.like(params[:track_id])
      else
        playlist.dislike(params[:track_id])
      end
    else
      if rating.liked != liked
        rating.liked = !rating.liked
        rating.time = params[:time]
        rating.percentage = params[:percentage]
      end
      rating.save
    end

    render nothing: true
  end
end
