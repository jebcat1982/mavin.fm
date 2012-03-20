class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks
  has_many :taggings
  has_many :tags, :through => :taggings

  validates :e_id, :uniqueness => { :scope => :source }

  def bandcamp_new(args = {}, band = nil)
    album = self.new

    album.title         = args['title']
    album.release_date  = args['release_date']
    album.downloadable  = args['downloadable']
    album.url           = args['url']
    album.about         = args['about']
    album.credits       = args['credits']
    album.small_art_url = args['small_art_url']
    album.large_art_url = args['large_art_url']
    album.artist        = args['artist'] || band.name
    album.band_id       = band.id
    album.e_id          = args['album_id']
    album.e_band_id     = args['band_id']
    album.source        = 'bc'

    album
  end
end
