class PlaylistTrack < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :tracks
end
