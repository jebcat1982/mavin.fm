require 'spec_helper'

describe PlaylistsController do
  def valid_attributes
    {}
  end
  
  def valid_session
    {}
  end

  pending "GET index" do
    it "assigns all playlists as @playlists" do
      playlist = Playlist.create! valid_attributes
      get :index, {}, valid_session
      assigns(:playlists).should eq([playlist])
    end
  end

  pending "GET show" do
    it "assigns the requested playlist as @playlist" do
      playlist = Playlist.create! valid_attributes
      get :show, {:id => playlist.to_param}, valid_session
      assigns(:playlist).should eq(playlist)
    end
  end

  pending "POST create" do
    describe "with valid params" do
      it "creates a new Playlist" do
        expect {
          post :create, {:playlist => valid_attributes}, valid_session
        }.to change(Playlist, :count).by(1)
      end

      it "assigns a newly created playlist as @playlist" do
        post :create, {:playlist => valid_attributes}, valid_session
        assigns(:playlist).should be_a(Playlist)
        assigns(:playlist).should be_persisted
      end

      it "redirects to the created playlist" do
        post :create, {:playlist => valid_attributes}, valid_session
        response.should redirect_to(Playlist.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved playlist as @playlist" do
        # Trigger the behavior that occurs when invalid params are submitted
        Playlist.any_instance.stub(:save).and_return(false)
        post :create, {:playlist => {}}, valid_session
        assigns(:playlist).should be_a_new(Playlist)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Playlist.any_instance.stub(:save).and_return(false)
        post :create, {:playlist => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  pending "DELETE destroy" do
    it "destroys the requested playlist" do
      playlist = Playlist.create! valid_attributes
      expect {
        delete :destroy, {:id => playlist.to_param}, valid_session
      }.to change(Playlist, :count).by(-1)
    end

    it "redirects to the playlists list" do
      playlist = Playlist.create! valid_attributes
      delete :destroy, {:id => playlist.to_param}, valid_session
      response.should redirect_to(playlists_url)
    end
  end
end
