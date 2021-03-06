require 'spec_helper'

describe Bandcamp do
  use_vcr_cassette "Bandcamp", :record => :new_episodes

  describe "modules" do
    it "should retrieve a band_id and album_id from the url module" do
      bc = Bandcamp.new('http://featurelessghost.bandcamp.com/album/new-moods')
      info = bc.url_module
      info['band_id'].should_not be_nil
      info['album_id'].should_not be_nil
    end

    it "should retrieve all the data from the band module" do
      bc = Bandcamp.new
      band = bc.band_module(2153716647)
      band['offsite_url'].should_not be_nil
      band['url'].should_not be_nil
      band['band_id'].should_not be_nil
      band['subdomain'].should_not be_nil
      band['name'].should_not be_nil
    end

    it "should retrieve data from the album module" do
      bc = Bandcamp.new
      album = bc.album_module(3152700495)
      album['title'].should_not be_nil
      album['release_date'].should_not be_nil
      album['url'].should_not be_nil
      album['small_art_url'].should_not be_nil
      album['large_art_url'].should_not be_nil
    end

    it "should retrieve tracks from the album module" do
      bc = Bandcamp.new
      album = bc.album_module(3152700495)
      album['tracks'].count.should == 8
    end

    it "should retrieve data from the track module" do
      bc = Bandcamp.new
      track = bc.track_module(1974108541)
      track['downloadable'].should_not be_nil
      track['url'].should_not be_nil
      track['band_id'].should_not be_nil
      track['duration'].should_not be_nil
      track['streaming_url'].should_not be_nil
      track['track_id'].should_not be_nil
      track['title'].should_not be_nil
    end
  end

  describe "saves" do
    it "should create a track and tags" do
      track = Bandcamp.new('http://featurelessghost.bandcamp.com/track/lost-city-cont', ['dance', 'electronic', 'house'])
      track.save
      track.should have(3).tags
    end
  end
end
