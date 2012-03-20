class Track < ActiveRecord::Base
  belongs_to :album
  belongs_to :band
  has_many :taggings
  has_many :tags, :through => :taggings

  validates :e_id, :uniqueness => { :scope => :source }

  def self.find_recommendation(playlist)
    pid = "p#{playlist.id}"

    playlist_tracks = playlist.tracks.order('created_at DESC').limit(15)
    tracks = self.all

    total = 0
    size = 0
    intersection = {}

    tracks.each do |track|
      unless playlist_tracks.include?(track)
        tid = "t#{track.id}"
        count = (Discovery.redis.sinter pid, tid).count
        intersection[track.id] = count
        total += count
        size += 1
      end
    end

    return Track.first(:order => 'RANDOM()') if total == 0 || size == 0

    mean = total / size
    tmp = 0
    
    intersection.each do |tid,count|
      tmp += (count - mean) ** 2
    end
    std = Math.sqrt(tmp/mean)

    possible = []
    intersection.each do |tid,count|
      possible << tid if count >= std+mean
    end

    self.find(possible[rand(possible.length-1)])
  end

  def self.bandcamp_new(args = {}, album = {}, band = nil)
    track = self.new

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

  def self.soundcloud_new(args = {})
    track = self.new

    track.title          = args['title']
    track.duration       = args['duration'] / 1000
    track.downloadable   = args['downloadable']
    track.url            = args['permalink_url']
    track.streaming_url  = args['stream_url']
    track.about          = args['description']
    track.small_art_url  = args['artwork_url']
    track.large_art_url  = args['artwork_url']
    track.artist         = args['user']['username']
    track.e_id           = args['id']
    track.e_band_id      = args['user-id']
    track.source         = 'sc'

    track
  end
end
