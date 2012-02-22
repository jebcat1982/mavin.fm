class PlaylistsController < ApplicationController
  respond_to :json
  before_filter :create_session

  def index
    respond_with @playlists = Playlist.where(:session_id => current_session)
  end

  def show
    respond_with @playlist = Playlist.find(params[:id])
  end

  def create
    @playlist = Playlist.new(params[:playlist])
    @playlist.session_id = current_session
    @playlist.save
    respond_with @playlist
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    respond_with head :no_content
  end
end
