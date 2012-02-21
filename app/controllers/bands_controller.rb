class BandsController < ApplicationController
  respond_to :json

  def show
    respond_with @band = Band.find(params[:id])
  end
end
