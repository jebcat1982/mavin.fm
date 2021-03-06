class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  validates :track_id, :uniqueness => { :scope => [:user_id, :session_id, :playlist_id] }
end
