class MusicController < ApplicationController
  respond_to :json, :html

  def show
  end

  def new
    @music = Music.new
    respond_with @music
  end

  def create
    @music = Music.new(params[:url], params[:raw_tags])

    if @music.valid?
      Resque.enque(Add, params[:url], params[:raw_tags])
      redirect_to new_music_path, notice: "You've successfully added your music."
    else
      render action: 'new'
    end
  end
end
