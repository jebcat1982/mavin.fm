class PlaylistTrack < ActiveRecord::Base
  belongs_to :playlist
  has_one :track
end
