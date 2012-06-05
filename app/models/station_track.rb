class StationTrack < ActiveRecord::Base
  belongs_to :station
  belongs_to :track
end
