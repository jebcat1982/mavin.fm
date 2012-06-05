require 'spec_helper'

describe Station do
  describe "callbacks" do
    it "should create taggings for tag associations" do
      FactoryGirl.create(:tag)

      station = Station.new(genre: 'jazz')
      station.save
      station.tags.count.should == 1
    end
  end
end
