class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :playlist_tracks
  has_many :tracks, :through => :playlist_tracks

  has_many :taggings
  has_many :tags, :through => :taggings, :uniq => true
end
