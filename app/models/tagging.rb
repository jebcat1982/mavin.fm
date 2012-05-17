class Tagging < ActiveRecord::Base
  belongs_to :album
  belongs_to :tag
  belongs_to :track
  belongs_to :known_artist
  belongs_to :known_album
  belongs_to :known_track
end
