class PlaylistTrack < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :track

  def as_json(options={})
    super(:include => :track)
  end
end
