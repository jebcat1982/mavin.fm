require 'spec_helper'

describe PlaylistTracksController do
  def valid_attributes
    {
      :playlist_id => @playlist.id
    }
  end

  def valid_session
    {}
  end

  before(:each) do
    @playlist = Factory.create(:playlist)
  end

  pending "GET index" do
    it "assigns all playlist_tracks as @playlist_tracks" do
      playlist_track = PlaylistTrack.create! valid_attributes
      get :index, {}, valid_session
      assigns(:playlist_tracks).should eq([playlist_track])
    end
  end

  pending "GET show" do
    it "assigns the requested playlist_track as @playlist_track" do
      playlist_track = PlaylistTrack.create! valid_attributes
      get :show, {:id => playlist_track.to_param}, valid_session
      assigns(:playlist_track).should eq(playlist_track)
    end
  end

  pending "POST create" do
    describe "with valid params" do
      it "creates a new PlaylistTrack" do
        puts valid_attributes
        expect {
          post :create, {:playlist_track => valid_attributes}, valid_session
        }.to change(PlaylistTrack, :count).by(1)
      end

      it "assigns a newly created playlist_track as @track" do
        post :create, {:playlist_track => valid_attributes}, valid_session
        assigns(:playlist_track).should be_a(Track)
        assigns(:playlist_track).should be_persisted
      end

      it "redirects to the created playlist_track" do
        post :create, {:playlist_track => valid_attributes}, valid_session
        response.should redirect_to(PlaylistTrack.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved playlist_track as @playlist_track" do
        # Trigger the behavior that occurs when invalid params are submitted
        PlaylistTrack.any_instance.stub(:save).and_return(false)
        post :create, {:playlist_track => {}}, valid_session
        assigns(:playlist_track).should be_a_new(PlaylistTrack)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        PlaylistTrack.any_instance.stub(:save).and_return(false)
        post :create, {:playlist_track => {}}, valid_session
        response.should render_template("new")
      end
    end
  end
end
