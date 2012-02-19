class PlaylistTracksController < ApplicationController
  # GET /playlist_tracks
  # GET /playlist_tracks.json
  def index
    @playlist_tracks = PlaylistTrack.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlist_tracks }
    end
  end

  # GET /playlist_tracks/1
  # GET /playlist_tracks/1.json
  def show
    @playlist_track = PlaylistTrack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @playlist_track }
    end
  end

  # GET /playlist_tracks/new
  # GET /playlist_tracks/new.json
  def new
    @playlist_track = PlaylistTrack.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @playlist_track }
    end
  end

  # GET /playlist_tracks/1/edit
  def edit
    @playlist_track = PlaylistTrack.find(params[:id])
  end

  # POST /playlist_tracks
  # POST /playlist_tracks.json
  def create
    @playlist = Playlist.find(params[:playlist_id])
    random = rand(Track.count)
    @track = Track.find(random)
    @playlist.playlist_tracks.build(:track_id => @track)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist_track, notice: 'Playlist track was successfully created.' }
        format.json { render json: @track, status: :created, location: @track}
      else
        format.html { render action: "new" }
        format.json { render json: @playlist_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /playlist_tracks/1
  # PUT /playlist_tracks/1.json
  def update
    @playlist_track = PlaylistTrack.find(params[:id])

    respond_to do |format|
      if @playlist_track.update_attributes(params[:playlist_track])
        format.html { redirect_to @playlist_track, notice: 'Playlist track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @playlist_track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlist_tracks/1
  # DELETE /playlist_tracks/1.json
  def destroy
    @playlist_track = PlaylistTrack.find(params[:id])
    @playlist_track.destroy

    respond_to do |format|
      format.html { redirect_to playlist_tracks_url }
      format.json { head :no_content }
    end
  end
end
