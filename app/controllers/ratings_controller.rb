class RatingsController < ApplicationController
  def rate
    liked = params[:liked] == "true" ? true : false

    @rating = Rating.where(user_id: current_user.id, track_id: params[:track_id], station_id: params[:station_id]).first

    if @rating.nil?
      @rating = current_user.ratings.create(track_id: params[:track_id], station_id: params[:station_id], liked: liked, time: params[:time], percentage: params[:percentage])

      station = Station.find(params[:station_id])
      if liked
        station.like(params[:track_id])
      else
        station.dislike(params[:track_id])
      end
    else
      if @rating.liked != liked
        @rating.liked = !@rating.liked
        @rating.time = params[:time]
        @rating.percentage = params[:percentage]
      end
      @rating.save
    end

    render nothing: true
  end
end
