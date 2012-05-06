class PlaylistsController < ApplicationController
  respond_to :json
  before_filter :create_session

  def index
    if current_user
      respond_with @playlists = Playlist.where(:user_id => current_user, :deleted => false)
    else
      respond_with @playlists = Playlist.where(:session_id => current_session, :deleted => false)
    end
  end

  def show
    respond_with @playlist = Playlist.find(params[:id])
  end

  def create
    @playlist = Playlist.new(params[:playlist])
    if current_user
      @playlist.user_id = current_user
    else
      @playlist.session_id = current_session
    end
    @playlist.save

    tags = @playlist.search_term.split(',')
    tags.each do |tag|
      t = Tag.find_or_create_by_name(tag.strip)
      Discovery.redis.sadd "p#{@playlist.id}", t.id
    end

    @playlist.set_name
    @playlist.save

    respond_with @playlist
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.update_attributes(deleted: true)
    respond_with head :no_content
  end
end
