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
    @tag      = Tag.where('name LIKE ?', "%#{params[:search_term]}%").first
    @album    = @tag.albums[rand(@tag.albums.length)]
    @track    = @album.tracks[rand(@album.tracks.length)]

    @playlist.playlist_tracks.build(:track_id => @track.id)
    @playlist.save
    respond_with @track
  end
end
