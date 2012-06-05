class Station < ActiveRecord::Base
  belongs_to :user
  has_many :station_tracks
  has_many :tracks, :through => :station_tracks

  has_many :taggings
  has_many :tags, :through => :taggings, :uniq => true

  attr_accessor :genre

  after_create :add_tags

  def add_tags
    unless genre.nil?
      self.tags = Tag.where("name LIKE '%#{genre}%'")
      self.save
    end
  end
end
