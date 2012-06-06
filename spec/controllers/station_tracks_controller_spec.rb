require 'spec_helper'

describe StationTracksController do
  before(:each) do
    user = User.new(username: 'tomer', email: 'tomer@awesome.com', registered: false)
    user.save(validate: false)
    controller.stub current_user: user

    @track = Track.create
    Track.stub(:find_next).and_return(@track)

    @station = FactoryGirl.create(:station, user_id: controller.current_user.id)
  end

  describe "GET 'index'" do
    it "returns success" do
      get 'index', format: :json, station_id: @station.id
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    it "returns success" do
      post 'create', format: :json, station_id: @station.id
      response.should be_success
    end

    it "should create a station_track" do
      expect {
        post 'create', format: :json, station_id: @station.id
      }.to change(StationTrack, :count).by(1)
    end

    it "returns a track" do
      post 'create', format: :json, station_id: @station.id
      response.body.should == @track.to_json
    end
  end
end
