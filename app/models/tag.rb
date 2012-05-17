class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :albums, :through => :taggings
  has_many :tracks, :through => :taggings
  has_many :known_artists, :through => :taggings
  has_many :known_albums,  :through => :taggings
  has_many :known_tracks,  :through => :taggings

  def self.autocomplete_name(partial)
    self.where('name LIKE ?', "%#{partial}%").select([:id, :name])
  end
end
