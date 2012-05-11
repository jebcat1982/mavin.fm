class PlaylistsController < ApplicationController
  respond_to :json
  before_filter :create_session

  def index
    if current_user
      respond_with @playlists = Playlist.where(:user_id => current_user.id, :deleted => false).order('created_at ASC')
    else
      respond_with @playlists = Playlist.where(:session_id => current_session, :deleted => false).order('created_at ASC')
    end
  end

  def show
    if current_user
      @playlist = current_user.playlists.find(params[:id], conditions: { deleted: false })
    else
      @playlist = Playlist.where(session_id: current_session, id: params[:id], deleted: false).first
    end

    raise ActiveRecord::RecordNotFound, "Playlist not found" if @playlist.nil?
    respond_with @playlist
  end

  def create
    @playlist = Playlist.new(params[:playlist])
    if current_user
      @playlist.user_id = current_user.id
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
    if current_user
      @playlist = current_user.playlists.find(params[:id])
    else
      @playlist = Playlist.where(session_id: current_session, id: params[:id]).first
    end
    @playlist.update_attributes(deleted: true) unless @playlist.nil?
    respond_with :no_content
  end
end
