class Bandcamp
  attr_accessor :url, :tags

  def initialize(url = nil, tags = nil)
    @url  = url
    @tags = tags
  end

  def save
    @info_json = url_module()
    @band      = find_or_create_band()

    get_album() if self.url.index('/album/')
    get_track() if self.url.index('/track/')
  end

  def get_album
    @album_info = album_module()

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

  def build_tracks
    @album_info["tracks"].each do |track|
      # If the tracks don't have these values take them from the album
      downloadable  = track["downloadable"]  || @album.downloadable
      small_art_url = track["small_art_url"] || @album.small_art_url
      large_art_url = track["large_art_url"] || @album.large_art_url
      artist        = track["artist"]        || @album.artist         || @band.name

      t = @album.tracks.build(
        :title         => track["title"],
        :number        => track["number"],
        :duration      => track["duration"],
        :release_date  => track["release_date"],
        :downloadable  => downloadable,
        :url           => track["url"],
        :streaming_url => track["streaming_url"] + "&api_key=#{APIKeys::BANDCAMP}",
        :lyrics        => track["lyrics"],
        :about         => track["about"],
        :credits       => track["credits"],
        :small_art_url => small_art_url,
        :large_art_url => large_art_url,
        :artist        => artist,
        :e_id          => track["track_id"],
        :e_album_id    => track["album_id"],
        :e_band_id     => track["band_id"],

        :album_title   => @album.title,
        :album_url     => @album.url,
        :artist_url    => @band.url,
        :band_subdomain => @band.subdomain
      )

      @tags.each do |tag|
        t.taggings.build(:tag_id => tag.id)
      end
    end
  end

  def find_or_create_band
    band = Band.where(:e_id => @info_json["band_id"]).first

    unless band
      band_json = band_module()

      band.offsite_url  = band_json["offsite_url"]
      band.url          = band_json["url"]
      band.subdomain    = band_json["subdomain"]
      band.name         = band_json["name"]
      band.save
    end

    band
  end

  def url_module
    uri = URI.parse("http://api.bandcamp.com/api/url/1/info?key=#{APIKeys::BANDCAMP}&url=#{self.url}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def band_module
    uri = URI.parse("http://api.bandcamp.com/api/band/3/info?key=#{APIKeys::BANDCAMP}&band_id=#{@band.e_id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def album_module
    uri = URI.parse("http://api.bandcamp.com/api/album/2/info?key=#{APIKeys::BANDCAMP}&album_id=#{@info_json['album_id']}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def track_module
    uri = URI.parse("http://api.bandcamp.com/api/track/3/info?key=#{APIKeys::BANDCAMP}&track_id=#{@info_json['track_id']}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
