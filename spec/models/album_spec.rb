require 'spec_helper'

describe Album do
  use_vcr_cassette "Album", :record => :new_episodes

  pending "validations" do
    it "should make sure there's a url" do
      album = Factory.build(:album, url: nil)
      album.should_not be_valid
    end
  end
end
