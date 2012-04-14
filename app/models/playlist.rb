class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :playlist_tracks
  has_many :tracks, :through => :playlist_tracks

  has_many :taggings
  has_many :tags, :through => :taggings, :uniq => true

  def like(track)
    track_tags = Discovery.redis.smembers "t#{track}"
    weights = Discovery.redis.mapped_hmget "ptw#{id}", *track_tags

    Discovery.redis.pipelined {
      weights.each do |tag,weight|
        Discovery.redis.hincrby "ptw#{id}", tag, 1
        Discovery.redis.sadd "p#{id}", tag
      end
    }
  end

  def dislike(track)
    track_tags = Discovery.redis.smembers "t#{track}"
    weights = Discovery.redis.mapped_hmget "ptw#{id}", *track_tags

    Discovery.redis.pipelined {
      weights.each do |tag,weight|
        Discovery.redis.hincrby "ptw#{id}", tag, -1
        Discovery.redis.sadd "p#{id}", tag
      end
    }
  end
end
