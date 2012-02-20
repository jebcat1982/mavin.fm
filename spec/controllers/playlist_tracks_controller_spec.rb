require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PlaylistTracksController do

  # This should return the minimal set of attributes required to create a valid
  # PlaylistTrack. As you add validations to PlaylistTrack, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :playlist_id => @playlist.id
    }
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PlaylistTracksController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  before(:each) do
    @playlist = Factory.create(:playlist)
  end

  describe "GET index" do
    it "assigns all playlist_tracks as @playlist_tracks" do
      playlist_track = PlaylistTrack.create! valid_attributes
      get :index, {}, valid_session
      assigns(:playlist_tracks).should eq([playlist_track])
    end
  end

  describe "GET show" do
    it "assigns the requested playlist_track as @playlist_track" do
      playlist_track = PlaylistTrack.create! valid_attributes
      get :show, {:id => playlist_track.to_param}, valid_session
      assigns(:playlist_track).should eq(playlist_track)
    end
  end

  describe "GET new" do
    it "assigns a new playlist_track as @playlist_track" do
      get :new, {}, valid_session
      assigns(:playlist_track).should be_a_new(PlaylistTrack)
    end
  end

  describe "GET edit" do
    it "assigns the requested playlist_track as @playlist_track" do
      playlist_track = PlaylistTrack.create! valid_attributes
      get :edit, {:id => playlist_track.to_param}, valid_session
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

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested playlist_track" do
        playlist_track = PlaylistTrack.create! valid_attributes
        # Assuming there are no other playlist_tracks in the database, this
        # specifies that the PlaylistTrack created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        PlaylistTrack.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => playlist_track.to_param, :playlist_track => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested playlist_track as @playlist_track" do
        playlist_track = PlaylistTrack.create! valid_attributes
        put :update, {:id => playlist_track.to_param, :playlist_track => valid_attributes}, valid_session
        assigns(:playlist_track).should eq(playlist_track)
      end

      it "redirects to the playlist_track" do
        playlist_track = PlaylistTrack.create! valid_attributes
        put :update, {:id => playlist_track.to_param, :playlist_track => valid_attributes}, valid_session
        response.should redirect_to(playlist_track)
      end
    end

    describe "with invalid params" do
      it "assigns the playlist_track as @playlist_track" do
        playlist_track = PlaylistTrack.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PlaylistTrack.any_instance.stub(:save).and_return(false)
        put :update, {:id => playlist_track.to_param, :playlist_track => {}}, valid_session
        assigns(:playlist_track).should eq(playlist_track)
      end

      it "re-renders the 'edit' template" do
        playlist_track = PlaylistTrack.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PlaylistTrack.any_instance.stub(:save).and_return(false)
        put :update, {:id => playlist_track.to_param, :playlist_track => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  pending "DELETE destroy" do
    it "destroys the requested playlist_track" do
      playlist_track = PlaylistTrack.create! valid_attributes
      expect {
        delete :destroy, {:id => playlist_track.to_param}, valid_session
      }.to change(PlaylistTrack, :count).by(-1)
    end

    it "redirects to the playlist_tracks list" do
      playlist_track = PlaylistTrack.create! valid_attributes
      delete :destroy, {:id => playlist_track.to_param}, valid_session
      response.should redirect_to(playlist_tracks_url)
    end
  end

end
