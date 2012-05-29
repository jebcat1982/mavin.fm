class Station < ActiveRecord::Base
  belongs_to :user
  has_many :station_tracks
  has_many :tracks, :through => :station_tracks

  has_many :taggings
  has_many :tags, :through => :taggings, :uniq => true
end
