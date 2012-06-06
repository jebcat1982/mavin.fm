require 'spec_helper'

describe Track do
  describe "find tracks" do
    before(:each) do
      track = Track.create
      tag = Tag.create(name: 'jazz')
      track.tags << tag

      Track.stub(:get_all_tracks).and_return([track.id.to_s])
      Track.stub(:get_counts).and_return([1])
      Track.stub(:tally).and_return([{track.id.to_s => 1}, 1, 1])
      Track.stub(:update_station_sets).and_return("")
    end

    it "should find a track when the station has tags" do
      station = Station.create(genre: 'jazz')
      track = Track.find_next(station)

      track.should_not be_nil
      track.should be_a(Track)
    end

    it "should find a random track when the station has no tags" do
      station = Station.create
      track = Track.find_next(station)

      track.should_not be_nil
      track.should be_a(Track)
    end
  end
end
