class StationTracksController < ApplicationController
  respond_to :json

  def index
    @station = current_user.stations.find(params[:station_id])
    respond_with @station.station_tracks.limit(5).order('created_at DESC').reverse
  end

  def create
    @station = current_user.stations.find(params[:station_id])
    @track   = Track.find_next(@station)

    @station.station_tracks.create(track_id: @track.id)

    respond_with @track
  end
end
