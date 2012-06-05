require 'spec_helper'

describe StationTracksController do
  before(:each) do
    user = User.new(username: 'tomer', email: 'tomer@awesome.com', registered: false)
    user.save(validate: false)
    controller.stub current_user: user

    @station = FactoryGirl.create(:station, user_id: controller.current_user.id)
  end

  describe "GET 'index'" do
    it "returns success" do
      get 'index', format: :json, station_id: @station.id
      response.should be_success
    end
  end
end
