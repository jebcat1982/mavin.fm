class TracksController < ApplicationController
  respond_to :json

  def index
    random = rand(Track.count)
    respond_with @track = Track.find(random)
  end

  def show
    respond_with @track = Track.find(params[:id])
  end
end
