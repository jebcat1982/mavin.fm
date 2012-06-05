require 'spec_helper'

describe Station do
  describe "callbacks" do
    it "should create taggings for tag associations" do
      FactoryGirl.create(:tag)

      station = Station.new(genre: 'jazz')
      station.save
      station.tags.count.should == 1
    end

    it "should create a name" do
      station = Station.new(genre: 'jazz')
      station.save
      station.name.should_not be_nil
      station.name.should_not == ""
      station.name.should == "Jazz Playlist"
    end
  end
end
