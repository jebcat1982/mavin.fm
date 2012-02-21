class PlaylistsController < ApplicationController
  respond_to :json

  def index
    respond_with @playlists = Playlist.all
  end

  def show
    respond_with @playlist = Playlist.find(params[:id])
  end

  def create
    @playlist = Playlist.new(params[:playlist])
    @playlist.save
    respond_with @playlist
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    respond_with head :no_content
  end
end
