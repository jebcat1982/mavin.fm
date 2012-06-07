require 'spec_helper'

describe RatingsController do
  before(:each) do
    user = User.new(username: 'tomer', email: 'tomer@awesome.com', registered: false)
    user.save(validate: false)
    controller.stub current_user: user

    Station.stub(:like).and_return('')
    Station.stub(:dislike).and_return('')

    @track = Track.create
    @station = FactoryGirl.create(:station, user_id: controller.current_user.id)
  end

  describe "rate" do
    it "should create a new rating when a previous one doesn't exit" do
      expect {
        post 'rate', format: :json, liked: "true", station_id: @station.id, track_id: @track.id
      }.to change(Rating, :count).by(1)
    end

    it "should be for the correct station and track" do
      post 'rate', format: :json, liked: "true", station_id: @station.id, track_id: @track.id
      assigns(:rating).station_id.should == @station.id
      assigns(:rating).track_id.should == @track.id
    end
  end
end
