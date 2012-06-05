class StationsController < ApplicationController
  respond_to :json

  def index
    respond_with @stations = current_user.stations.where(deleted: false)
  end

  def show
    respond_with @station = current_user.stations.where(id: params[:id], deleted: false).first
  end

  def create
    respond_with @station = current_user.stations.create(params[:station])
  end

  def destroy
    @station = current_user.stations.find(params[:id])
    @station.update_attributes(deleted: true)
    respond_with :no_content
  end
end
