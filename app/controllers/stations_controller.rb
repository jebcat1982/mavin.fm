class StationsController < ApplicationController
  respond_to :json

  def index
    respond_with @stations = current_user.stations.where(deleted: false)
  end
end
