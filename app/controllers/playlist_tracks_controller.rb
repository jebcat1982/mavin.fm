class PlaylistTracksController < ApplicationController
  respond_to :json

  def index
    @playlist = Playlist.find(params[:playlist_id])
    respond_with @playlist.playlist_tracks.limit(5).order('created_at DESC').reverse
  end

  def show
    respond_with @playlist_track = PlaylistTrack.find(params[:id])
  end

  def create
    @playlist = Playlist.find(params[:playlist_id])
    @track    = Track.find_recommendation(@playlist)

    @playlist.playlist_tracks.build(:track_id => @track.id)
    @playlist.save

    @rating = Rating.where(user_id: current_user, playlist_id: @playlist, track_id: @track).first

    unless @rating.nil?
      respond_with @track.as_json(@rating.liked), :location => nil
    else
      respond_with @track.as_json(nil), :location => nil
    end
  end
end
