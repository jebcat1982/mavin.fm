class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks
  has_many :tags
end
