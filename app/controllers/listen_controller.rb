class ListenController < ApplicationController
  def index
    @likes = Rating.where(liked: true).order('created_at DESC').limit(5)
  end
end
