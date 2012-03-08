class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :albums, :through => :taggings
  has_many :tracks, :through => :taggings
end
