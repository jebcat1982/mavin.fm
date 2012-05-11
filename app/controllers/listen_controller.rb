class ListenController < ApplicationController
  before_filter :create_session, :establish_session

  def index
    @likes = Rating.where(liked: true).order('created_at DESC').limit(5)
  end
end
