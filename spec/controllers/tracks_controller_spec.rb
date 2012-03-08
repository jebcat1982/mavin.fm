require 'spec_helper'

describe TracksController do
  def valid_attributes
    {}
  end
  
  def valid_session
    {}
  end

  pending "GET index" do
    it "assigns all tracks as @tracks" do
      track = Track.create! valid_attributes
      get :index, {}, valid_session
      assigns(:tracks).should eq([track])
    end
  end

  pending "GET show" do
    it "assigns the requested track as @track" do
      track = Track.create! valid_attributes
      get :show, {:id => track.to_param}, valid_session
      assigns(:track).should eq(track)
    end
  end
end
