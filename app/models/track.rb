class Track < ActiveRecord::Base
  belongs_to :album
  belongs_to :band
  has_many :taggings
  has_many :tags, :through => :taggings
  has_many :likes
  has_many :dislikes

  validates :e_id, :uniqueness => { :scope => :source }

  def self.find_weighted_similar(playlist)
    pid = "p#{playlist.id}"

    #playlist_tracks = Discovery.redis.smembers "pts#{playlist.id}"
    tracks = Discovery.redis.smembers "tracks"
    #diff = Discovery.redis.sdiff "tracks", "pts#{playlist.id}"
    playlist_tracks = playlist.tracks.select('tracks.id').order('playlist_tracks.created_at DESC').limit(15).map(&:id)

    total = 0
    size  = 0
    pweights = Discovery.redis.hgetall "ptw#{playlist.id}"
    weights = {}

    tracks.each do |track|
      unless playlist_tracks.include?(track)
        tid = "t#{track}"

        weights[track] = 0
        
        tags = Discovery.redis.smembers tid
        tags.each do |tag|
          unless pweights[tag].nil?
            if pweights[tag].to_i > 0
              weights[track] += pweights[tag].to_i
            end
          end
        end
          
        total += weights[track]
        size  += 1
      end
    end

    return Track.first(:order => 'RANDOM()') if total == 0 || size == 0

    mean = total.to_f / size.to_f

    possible = []
    weights.each do |tid,weight|
      possible << tid if weight >= mean # std+mean
    end

    self.find(possible[rand(possible.length-1)])
  end

  def self.find_recommendation(playlist)
    pid = "p#{playlist.id}"

    playlist_tracks = playlist.tracks.select('tracks.id').order('playlist_tracks.created_at DESC').limit(15)
    tracks = Discovery.redis.sdiff 'tracks', "pd#{playlist.id}", "pts#{playlist.id}"

    total = 0
    size = 0
    intersection = {}

    counts = Discovery.redis.pipelined {
      tracks.each do |track|
        tid = "t#{track}"
        Discovery.redis.sinterstore "temp", pid, tid
      end
    }

    tracks.each_with_index do |track,i|
      count = counts[i]
      if count != 0 
        intersection[track] = count
        total += count
        size += 1
      end
    end

    return Track.first(:order => 'RANDOM()') if total == 0 || size == 0

    mean = total.to_f / size.to_f
    tmp = 0

    possible = []
    intersection.each do |tid,count|
      possible << tid if count >= mean # std+mean
    end

    track = possible[rand(possible.length-1)]
    Discovery.redis.srem "pts#{playlist.id}", playlist_tracks.first.id unless playlist_tracks.empty?
    Discovery.redis.sadd "pts#{playlist.id}", track
    self.find(track.to_i)
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
