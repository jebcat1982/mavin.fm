class TagsController < ApplicationController
  respond_to :json

  def autocomplete
    respond_with @tag = Tag.autocomplete_name(params[:q])
  end
end
