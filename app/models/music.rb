class Music
  attr_accessor :url, :tags, :album_id

  def initialize(url = nil, tags = nil)
    self.url = url
    self.tags = tags
  end

  def save
    uri = URI.parse(self.url)

    if uri.host.index('bandcamp.com')
      b = Bandcamp.new(url, tags)
      b.save
    end

    soundcloud() if uri.host.index('soundcloud.com')
  end

  def soundcloud
    uri = URI.parse("http://api.soundcloud.com/resolve.json?url=#{self.url}&client_id=#{APIKeys::SOUNDCLOUD}")
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    
    response = Net::HTTP.get(json['location'])
    json = JSON.parse(response)

    if json['tracks']
      json['tracks'].each do |track|
        soundcloud_track(track)
      end
    else
      soundcloud_track(json)
    end
  end

  def soundcloud_track(json)
    track = Track.new

    track.title          = json['title']
    track.duration       = json['duration']
    track.downloadable   = json['downloadable']
    track.url            = json['permalink_url']
    track.streaming_url  = json['stream_url']
    track.about          = json['description']
    track.small_art_url  = json['artwork_url']
    track.large_art_url  = json['artwork_url']
    track.artist         = json['user']['username']
    track.e_id           = json['id']
    track.e_band_id      = json['user-id']

    @tags.each do |tag|
      track.taggings.build(:tag_id => tag.id)
    end

    track.save
  end

  def split_tags
    @tags = []
    self.tags.split(' ').map do |name|
      @tags << Tag.find_or_create_by_name(name.chomp)
    end
  end
end
