class Bandcamp
  attr_accessor :url, :tags

  def initialize(url = nil, tags = nil)
    self.url  = url
    self.tags = tags
  end

  def split_tags
    @tags = []
    self.tags.split(' ').map do |name|
      @tags << Tag.find_or_create_by_name(name.chomp)
    end
  end

  def save
    get_album() if self.url.index('/album/')
    get_track() if self.url.index('/track/')
  end

  # Calls each module method and stores the information to the model before saving. Also builds all
  # of the tracks into the album model before saving.
  def get_album
    url_module()   unless @info
    band_module()  unless @band
    album_module() unless @album_info

    @album = Album.new

    @album.title         = @album_info["title"]
    @album.release_date  = @album_info["release_date"]
    @album.downloadable  = @album_info["downloadable"]
    @album.url           = @album_info["url"]
    @album.about         = @album_info["about"]
    @album.credits       = @album_info["credits"]
    @album.small_art_url = @album_info["small_art_url"]
    @album.large_art_url = @album_info["large_art_url"]
    @album.artist        = @album_info["artist"] || @band.name
    @album.band_id       = @band.id
    @album.e_id          = @album_info["album_id"]
    @album.e_band_id     = @album_info["band_id"]

    build_tracks()

    @album.save
  end

  # These are methods for calling several different Bandcamp API modules in order to retrieve all of
  # the information on a band and album. Bandcamp API docs are located at http://bandcamp.com/developer

  # Makes a request to the URL module. This module will take a Bandcamp URL and resolve it to a 
  # Bandcamp band_id and a Bandcamp album_id
  def url_module
    uri = URI.parse("http://api.bandcamp.com/api/url/1/info?key=#{APIKeys::BANDCAMP}&url=#{self.url}")
    response = Net::HTTP.get(uri)
    @info = JSON.parse(response)
  end

  # Takes the Bandcamp band_id from the url_module and makes a request to the band module. This retrieves
  # all of the band information from Bandcamp such as name, offsite_url, etc.
  def band_module
    @band = Band.find_or_create_by_e_id(@info["band_id"])
    uri = URI.parse("http://api.bandcamp.com/api/band/3/info?key=#{APIKeys::BANDCAMP}&band_id=#{@band.e_id}")
    response = Net::HTTP.get(uri)
    band = JSON.parse(response)

    @band.offsite_url  = band["offsite_url"]
    @band.url          = band["url"]
    @band.subdomain    = band["subdomain"]
    @band.name         = band["name"]
    @band.save

    # Return the parsed JSON for the rspec test
    band
  end

  # Takes the album_id from the url_module and makes a request to the album module. This retrieves
  # all of the album information such as the artwork, free or not, and all of the album's tracks.
  def album_module
    album_id = @info["album_id"]
    uri = URI.parse("http://api.bandcamp.com/api/album/2/info?key=#{APIKeys::BANDCAMP}&album_id=#{album_id}")
    response = Net::HTTP.get(uri)
    @album_info = JSON.parse(response)
  end

  def track_module
    uri = URI.parse("http://api.bandcamp.com/api/track/3/info?key=#{APIKeys::BANDCAMP}&track_id=#{@info['track_id']}")
    response = Net::HTTP.get(uri)
    @track_info = JSON.parse(response)
  end
end
