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

  def get_track
    track_json = track_module
    album_json = album_module if track_json["album_id"]

    @track = Track.bandcamp_new(track_json, album_json, @band)

    @tags.each do |tag|
      @track.taggings.build(:tag_id => tag.id)
    end

    @track.save

    @tags.each do |tag|
      Discovery.redis.sadd "t#{@track.id}", tag.id
    end
  end

  def get_album
    @album_json = album_module()

    @album = Album.bandcamp_new(@album_json, @band)

    build_tracks()

    @album.save
  end

  def build_tracks
    @album_json[:tracks].each do |track|
      t = Track.bandcamp_new(track, @album_json, @band)
      @album.tracks << t
    
      @tags.each do |tag|
        t.taggings.build(:tag_id => tag.id)
        Discovery.redis.sadd "t#{t.id}", tag.id
      end
    end
  end

  def find_or_create_band
    band = Band.where(:e_id => @info_json["band_id"]).first

    unless band
      band_json = band_module()
      band = Band.bandcamp_new(band_json)
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
    uri = URI.parse("http://api.bandcamp.com/api/band/3/info?key=#{APIKeys::BANDCAMP}&band_id=#{@info_json['band_id']}")
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
