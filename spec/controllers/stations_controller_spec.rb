require 'spec_helper'

describe StationsController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', :format => :json
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns the selected station" do
      user = User.create(username: 'tomer', email: 'tomer@awesome.com', registered: false)
      controller.stub current_user: user
      station = FactoryGirl.create(:station, user_id: controller.current_user.id)
      get 'show', format: :json, id: station.id
      response.body.should == station.to_json
    end
  end

  describe "POST 'create'" do
    it "creates a station" do
      user = User.new(username: 'tomer', email: 'tomer@awesome.com', registered: false)
      user.save(validate: false)
      controller.stub current_user: user

      expect {
        post 'create', format: :json, :station => { name: "Tomer's Music Playlist" }
      }.to change(Station, :count).by(1)
    end
  end
end
