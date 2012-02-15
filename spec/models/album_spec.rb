require 'spec_helper'

describe Album do
  use_vcr_cassette
  
  it "creates an album" do
    album = Factory.build(:album)
    album.save
    album.should exist
  end
end
