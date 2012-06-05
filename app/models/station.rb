class Station < ActiveRecord::Base
  belongs_to :user
  has_many :station_tracks
  has_many :tracks, :through => :station_tracks

  has_many :taggings
  has_many :tags, :through => :taggings, :uniq => true

  attr_accessor :genre

  before_create :create_name
  after_create :add_tags

  def create_name
    if name.nil?
      if genre.nil?
        self.name = "Random Playlist"
      else
        self.name =  "#{genre.humanize} Playlist"
      end
    end
  end

  def add_tags
    unless genre.nil?
      self.tags = Tag.where("name LIKE '%#{genre}%'")
      self.save
    end
  end
end
