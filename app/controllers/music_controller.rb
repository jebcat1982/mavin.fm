class MusicController < ApplicationController
  respond_to :json, :html

  def show
  end

  def new
    @music = Music.new
    respond_with @music
  end

  def create
    @music = Music.new
    @music.url  = params[:music][:url]
    @music.tags = params[:music][:tags]
    @music.save

    redirect_to new_music_path, notice: "You've successfully added your music."
  end
end
