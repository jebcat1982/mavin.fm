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

describe AlbumsController do
  use_vcr_cassette

  # This should return the minimal set of attributes required to create a valid
  # Album. As you add validations to Album, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :url => 'http://featurelessghost.bandcamp.com/album/new-moods'
    }
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AlbumsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested album as @album" do
      album = Album.create! valid_attributes
      get :show, {:id => album.to_param}, valid_session
      assigns(:album).should eq(album)
    end
  end

  describe "GET new" do
    it "assigns a new album as @album" do
      get :new, {}, valid_session
      assigns(:album).should be_a_new(Album)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Album" do
        expect {
          post :create, {:album => valid_attributes}, valid_session
        }.to change(Album, :count).by(1)
      end

      it "assigns a newly created album as @album" do
        post :create, {:album => valid_attributes}, valid_session
        assigns(:album).should be_a(Album)
        assigns(:album).should be_persisted
      end

      it "redirects to the created album" do
        post :create, {:album => valid_attributes}, valid_session
        response.should redirect_to(Album.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved album as @album" do
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        post :create, {:album => {}}, valid_session
        assigns(:album).should be_a_new(Album)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Album.any_instance.stub(:save).and_return(false)
        post :create, {:album => {}}, valid_session
        response.should render_template("new")
      end
    end
  end
end
