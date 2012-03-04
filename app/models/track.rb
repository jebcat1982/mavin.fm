class Track < ActiveRecord::Base
  belongs_to :album
  belongs_to :band
  has_many :taggings
  has_many :tags, :through => :taggings
end
