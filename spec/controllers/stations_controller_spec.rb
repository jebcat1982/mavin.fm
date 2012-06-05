require 'spec_helper'

describe StationsController do
  before(:each) do
    user = User.new(username: 'tomer', email: 'tomer@awesome.com', registered: false)
    user.save(validate: false)
    controller.stub current_user: user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', :format => :json
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns the selected station" do
      station = FactoryGirl.create(:station, user_id: controller.current_user.id)

      get 'show', format: :json, id: station.id
      response.body.should == station.to_json
    end
  end

  describe "POST 'create'" do
    it "creates a station" do
      expect {
        post 'create', format: :json, :station => { name: "Tomer's Music Playlist" }
      }.to change(Station, :count).by(1)
    end

    it "creates a station with tags" do
      FactoryGirl.create(:tag)

      expect {
        post 'create', format: :json, :station => { name: "Tomer's Music Playlist", genre: "jazz" }
      }.to change(Tagging, :count).by(1)
    end
  end
end
