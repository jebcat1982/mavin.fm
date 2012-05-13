class PlaylistsController < ApplicationController
  respond_to :json

  def index
    respond_with @playlists = Playlist.where(:user_id => current_user.id, :deleted => false).order('created_at ASC')
  end

  def show
    respond_with @playlist = current_user.playlists.find(params[:id], conditions: { deleted: false })
  end

  def create
    @playlist = current_user.playlists.create(params[:playlist])

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
    @playlist = current_user.playlists.find(params[:id])
    @playlist.update_attributes(deleted: true)
    respond_with :no_content
  end
end
