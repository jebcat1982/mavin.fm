class PlaylistTracksController < ApplicationController
  respond_to :json

  def index
    respond_with @tracks = Track.all
  end

  def show
    respond_with @playlist_track = PlaylistTrack.find(params[:id])
  end

  def create
    @playlist = Playlist.find(params[:playlist_id])
    @tag      = Tag.where('name LIKE ?', "%#{params[:search_term]}%").first
    @album    = @tag.albums[rand(@tag.albums.length)]
    @track    = @album.tracks[rand(@album.tracks.length)]

    @playlist.playlist_tracks.build(:track_id => @track)
    @playlist.save
    respond_with @track
  end
end
