class AlbumsController < ApplicationController
  respond_to :json, :html

  def show
    respond_with (@album = Album.find(params[:id]))
  end

  def new
    @album = Album.new
    @album.tags.build
    respond_with @album
  end

  def create
    @album = Album.new(params[:album])
    
    if params[:tags] && params[:tags][:name]
      params[:tags][:name].split(' ').map do |name| 
        tag = Tag.find_or_create_by_name(name.chomp)
        @album.taggings.build(:tag_id => tag.id)
      end
    end

    if @album.save
      redirect_to @album, notice: 'Album was successfully created.'
    else
      render action: "new"
    end
  end
end
