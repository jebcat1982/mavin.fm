require 'spec_helper'

describe Album do
  use_vcr_cassette
  
  describe "bandcamp modules" do
    it "should retrieve a band_id from the URL module" do
      album = Factory.build(:album, url: 'http://featurelessghost.bandcamp.com/album/new-moods')
      info = album.url_module
      info["band_id"].should == 2153716647
    end
  end
end
