class RatingsController < ApplicationController
  def rate
    liked = params[:liked] == "true" ? true : false

    rating = Rating.where(user_id: current_user.id, track_id: params[:track_id], playlist_id: params[:playlist_id]).first

    if rating.nil?
      rating = current_user.ratings.create(track_id: params[:track_id], playlist_id: params[:playlist_id], liked: liked, time: params[:time], percentage: params[:percentage])

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
