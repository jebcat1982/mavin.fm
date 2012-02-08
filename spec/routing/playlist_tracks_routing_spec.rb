require "spec_helper"

describe PlaylistTracksController do
  describe "routing" do

    it "routes to #index" do
      get("/playlist_tracks").should route_to("playlist_tracks#index")
    end

    it "routes to #new" do
      get("/playlist_tracks/new").should route_to("playlist_tracks#new")
    end

    it "routes to #show" do
      get("/playlist_tracks/1").should route_to("playlist_tracks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/playlist_tracks/1/edit").should route_to("playlist_tracks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/playlist_tracks").should route_to("playlist_tracks#create")
    end

    it "routes to #update" do
      put("/playlist_tracks/1").should route_to("playlist_tracks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/playlist_tracks/1").should route_to("playlist_tracks#destroy", :id => "1")
    end

  end
end
