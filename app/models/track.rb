class Track < ActiveRecord::Base
  belongs_to :album
  belongs_to :band
  has_many :taggings
  has_many :tags, :through => :taggings

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
end
