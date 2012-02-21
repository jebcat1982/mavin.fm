class PlaylistTracksController < ApplicationController
  respond_to :json

  def show
    respond_with @playlist_track = PlaylistTrack.find(params[:id])
  end

  def create
    @playlist = Playlist.find(params[:playlist_id])
    random = rand(Track.count)
    @track = Track.find(random)
    @playlist.playlist_tracks.build(:track_id => @track)
    @playlist.save
    respond_with @track
  end

