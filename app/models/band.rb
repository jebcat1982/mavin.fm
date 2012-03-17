class Band < ActiveRecord::Base
  has_many :albums
  has_many :tracks, :through => :albums

  def self.bandcamp_new(args = {})
    band = self.new

    unless args.empty?
      band.offsite_url  = args[:offsite_url]
      band.url          = args[:url]
      band.subdomain    = args[:subdomain]
      band.name         = args[:name]
    end

    band
  end
end
