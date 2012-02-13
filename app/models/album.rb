class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks
  has_many :taggings
  has_many :tags, :through => :taggings
end
