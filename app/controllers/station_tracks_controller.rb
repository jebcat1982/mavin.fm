class StationTracksController < ApplicationController
  respond_to :json

  def index
    @station = current_user.stations.find(params[:station_id])
    respond_with @station.station_tracks.limit(5).order('created_at DESC').reverse
  end
end
