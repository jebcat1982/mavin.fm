require 'spec_helper'

describe Album do
  use_vcr_cassette "Album", :record => :new_episodes
  
  describe "bandcamp modules" do
    it "should retrieve a band_id from the URL module" do
      album = Factory.build(:album, url: 'http://featurelessghost.bandcamp.com/album/new-moods')
      info = album.url_module
      info["band_id"].should == 2153716647
    end

    it "should retrieve an album_id from the URL module" do
      album = Factory.build(:album, url: 'http://featurelessghost.bandcamp.com/album/new-moods')
      info = album.url_module
      info["album_id"].should == 3152700495
    end

    it "should retrieve a name from the band module" do
      album = Factory.build(:album, url: 'http://featurelessghost.bandcamp.com/album/new-moods')
      info = album.url_module
      band = album.band_module
      band["name"].should == "Featureless Ghost"
    end

    it "should retrieve a subdomain from the band module" do
      album = Factory.build(:album, url: 'http://featurelessghost.bandcamp.com/album/new-moods')
      info = album.url_module
      band = album.band_module
      band["subdomain"].should == "featurelessghost"
    end

    it "should get a title from the album module" do
      album = Factory.build(:album, url: 'http://featurelessghost.bandcamp.com/album/new-moods')
      album.url_module
      album.band_module
      json = album.album_module
      json["title"].should == "New Moods"
    end

    it "should get all of the album tracks from the album module" do
      album = Factory.build(:album, url: 'http://featurelessghost.bandcamp.com/album/new-moods')
      album.url_module
      album.band_module
      json = album.album_module   
      json["tracks"].size.should == 8
    end
  end

  describe "validations" do
    it "should make sure there's a url" do
      album = Factory.build(:album, url: nil)
      album.should_not be_valid
    end
  end
end
