class ListenController < ApplicationController
  before_filter :create_session, :establish_session

  def index
  end
end
