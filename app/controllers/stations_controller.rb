class StationsController < ApplicationController
  respond_to :json

  def index
    respond_with @stations = current_user.stations.where(deleted: false)
  end

  def show
    respond_with @station = Station.where(id: params[:id], deleted: false).first
  end
end