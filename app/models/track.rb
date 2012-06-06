class Track < ActiveRecord::Base
  belongs_to :album
  belongs_to :band
  has_many :taggings
  has_many :tags, :through => :taggings
  has_many :likes
  has_many :dislikes

  validates :e_id, :uniqueness => { :scope => :source }

  def self.find_next(station)
    sid = "s#{station.id}"
    tracks = get_all_tracks(station.id)

    counts = get_counts(tracks, sid)
    intersection, size, total = tally(tracks, counts)

    return Track.first(:order => 'RANDOM()') if total == 0 || size == 0

    mean = total.to_f / size.to_f

    possible = []
    intersection.each do |tid,count|
      possible << tid if count >= mean # std+mean
    end

    track = possible[rand(possible.length-1)]
    update_station_sets(station, track)
    self.find(track.to_i)
  end

  def self.update_station_sets(station, track)
    station_tracks = station.tracks.select('tracks.id').order('station_tracks.created_at DESC').limit(15)
    Discovery.redis.srem "sts#{station.id}", station_tracks.first.id unless station_tracks.empty?
    Discovery.redis.sadd "sts#{station.id}", track
  end
  
  def self.get_all_tracks(station_id)
    Discovery.redis.sdiff 'tracks', "sd#{station_id}", "sts#{station_id}"
  end

  def self.get_counts(tracks, key)
    Discovery.redis.pipelined {
      tracks.each do |track|
        Discovery.redis.sinterstore "temp", key, "t#{track}"
      end
    }
  end

  def self.tally(tracks, counts)
    intersection = {}
    size = 0
    total = 0

    tracks.each_with_index do |track,i|
      count = counts[i]
      if count != 0 
        intersection[track] = count
        total += count
        size += 1
      end
    end

    return intersection, size, total
  end

  def self.find_known_similar(key)
    tracks = Discovery.redis.smembers 'tracks'

    counts = get_counts(tracks, key)
    intersection, size, total = tally(tracks, counts)

    return Track.all(:order => 'RANDOM()', :limit => 5) if total == 0 || size == 0

    mean = total.to_f / size.to_f
    possible = []
    intersection.each do |tid,count|
      possible << tid if count >= mean # std+mean
    end

    similar = []
    
    while similar.count < 5 && possible.count != 0 do
      track = possible[rand(possible.length-1)]
      similar << self.find(track.to_i)
      possible.delete_at(track.to_i)
    end

    similar
  end


  def self.bandcamp_new(args = {}, album = {}, band = nil)
    track = self.new
    album = {} if album.nil?

    track.title         = args['title']
    track.number        = args['number']
    track.duration      = args['duration']
    track.release_date  = args['release_date']
    track.downloadable  = args['downloadable']  || album['downloadable']
    track.url           = args['url']
    track.streaming_url = args['streaming_url'] + "&api_key=#{APIKeys::BANDCAMP}"
    track.lyrics        = args['lyrics']
    track.about         = args['about']
    track.credits       = args['credits']
    track.small_art_url = args['small_art_url'] || album['small_art_url']
    track.large_art_url = args['large_art_url'] || album['large_art_url']
    track.artist        = args['artist']        || album['artist']          || band.name
    track.e_id          = args['track_id']
    track.e_album_id    = args['album_id']
    track.e_band_id     = args['band_id']

    track.album_title   = album['title']
    track.album_url     = album['url']
    track.artist_url    = band.url
    track.band_subdomain = band.subdomain
    track.source        = 'bc'

    track
  end

  def self.soundcloud_new(args = {}, url = '')
    track = self.new

    track.title          = args['title']
    track.duration       = args['duration'] / 1000
    track.downloadable   = args['downloadable']
    track.url            = args['permalink_url']
    track.album_url      = url
    track.streaming_url  = args['stream_url'] + "?client_id=#{APIKeys::SOUNDCLOUD}"
    track.about          = args['description']
    track.small_art_url  = args['artwork_url']
    track.large_art_url  = args['artwork_url']
    track.artist         = args['user']['username']
    track.artist_url     = args['user']['permalink_url']
    track.e_id           = args['id']
    track.e_band_id      = args['user-id']
    track.source         = 'sc'

    track
  end

  def as_json(rating, attributes = {})
    json = super(attributes)
    json['liked'] = nil
    json['liked'] = rating.liked unless rating.nil? 
    json
  end
end
