require 'spec_helper'

describe Album do
  use_vcr_cassette
  
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
  end
end
