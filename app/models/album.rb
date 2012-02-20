class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks
  has_many :taggings
  has_many :tags, :through => :taggings

  before_create :get_everything

  validates :url, :presence => true

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
    uri = URI.parse("http://api.bandcamp.com/api/album/2/info?key=#{APIKeys::BANDCAMP}&album_id=#{@info["album_id"]}")
    response = Net::HTTP.get(uri)
    @album = JSON.parse(response)
  end

  # Calls each module method and stores the information to the model before saving. Also builds all
  # of the tracks into the album model before saving.
  def get_everything
    url_module()
    band_module()
    album_module()

    self.title         = @album["title"]
    self.release_date  = @album["release_date"]
    self.downloadable  = @album["downloadable"]
    self.url           = @album["url"]
    self.about         = @album["about"]
    self.credits       = @album["credits"]
    self.small_art_url = @album["small_art_url"]
    self.large_art_url = @album["large_art_url"]
    self.artist        = @album["artist"]
    self.band_id       = @band.id
    self.e_id          = @album["album_id"]
    self.e_band_id     = @album["band_id"]

    build_tracks()
  end

  def build_tracks
    @album["tracks"].each do |track|
      # If the tracks don't have these values take them from the album
      downloadable  = track["downloadable"]  || self.downloadable
      small_art_url = track["small_art_url"] || self.small_art_url
      large_art_url = track["large_art_url"] || self.large_art_url
      artist        = track["artist"]        || self.artist

      self.tracks.build(
        :title         => track["title"],
        :number        => track["number"],
        :duration      => track["duration"],
        :release_date  => track["release_date"],
        :downloadable  => downloadable,
        :url           => track["url"],
        :streaming_url => track["streaming_url"],
        :lyrics        => track["lyrics"],
        :about         => track["about"],
        :credits       => track["credits"],
        :small_art_url => small_art_url,
        :large_art_url => large_art_url,
        :artist        => artist,
        :e_id          => track["track_id"],
        :e_album_id    => track["album_id"],
        :e_band_id     => track["band_id"]
      )
    end
  end
end
