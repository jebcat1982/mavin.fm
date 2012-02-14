class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks
  has_many :taggings
  has_many :tags, :through => :taggings

  before_save :get_everything

  private
  def url_module
    uri = URI.parse("http://http://api.bandcamp.com/api/url/1/info?key=#{APIKeys::BANDCAMP}&url=#{self.url}")
    response = Net::HTTP.get(uri)
    @info = JSON.parse(response)
  end

  def band_module
    @band = Band.find_or_create_by_e_id(@info["band_id"])
    uri = URI.parse("http://api.bandcamp.com/api/band/3/info?key=#{APIKeys::BANDCAMP}&band_id=#{band.e_id}")
    response = Net::HTTP.get(uri)
    band = JSON.parse(response)

    @band.offsite_url  = band["offsite_url"]
    @band.url          = band["url"]
    @band.subdomin     = band["subdomain"]
    @band.name         = band["name"]
    @band.save
  end

  def get_everything
    album_uri = URI.parse("http://api.bandcamp.com/api/album/2/info?key=#{APIKeys::BANDCAMP}&album_id=#{url_json["album_id"]}")
    album_response = Net::HTTP.get(album_uri)
    album_json = JSON.parse(album_response)

    self.title         = album_json["title"]
    self.release_date  = album_json["release_date"]
    self.downloadable  = album_json["downloadable"]
    self.url           = album_json["url"]
    self.about         = album_json["about"]
    self.credits       = album_json["credits"]
    self.small_art_url = album_json["small_art_url"]
    self.large_art_url = album_json["large_art_url"]
    self.artist        = album_json["artist"]
    self.band_id       = band.id
    self.e_id          = album_json["album_id"]
    self.e_band_id     = album_json["band_id"]

    album_json["tracks"].each do |t|
      #track = JSON.parse(t)
      self.tracks.build(
        :title         => track["title"],
        :number        => track["number"],
        :duration      => track["duration"],
        :release_date  => track["release_date"],
        :downloadable  => track["downloadable"],
        :url           => track["url"],
        :streaming_url => track["streaming_url"],
        :lyrics        => track["lyrics"],
        :about         => track["about"],
        :credits       => track["credits"],
        :small_art_url => track["small_art_url"],
        :large_art_url => track["large_art_url"],
        :artist        => track["artist"],
        :e_id          => track["track_id"],
        :e_album_id    => track["album_id"],
        :e_band_id     => track["band_id"]
      )
    end
  end
end
