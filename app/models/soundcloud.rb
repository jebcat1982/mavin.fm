class Soundcloud
  attr_accessor :url, :tags

  def initialize(url = nil, tags = nil)
    self.url  = url
    @tags = tags
  end
  
  def save 
    uri = URI.parse("http://api.soundcloud.com/resolve.json?url=#{self.url}&client_id=#{APIKeys::SOUNDCLOUD}")
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    
    uri = URI.parse(json['location'])
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)

    if json['tracks']
      json['tracks'].each do |track|
        soundcloud_track(track)
      end
    elsif ['track_count']
      uri = URI.parse("https://api.soundcloud.com/users/#{json['id']}/tracks.json&client_id=#{APIKeys::SOUNDCLOUD}")
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)
      json.each do |track|
        soundcloud_track(json)
      end
    else
      soundcloud_track(json)
    end
  end

  def soundcloud_track(json)
    track = Track.soundcloud_new(json)

    @tags.each do |tag|
      track.taggings.build(:tag_id => tag.id)
    end

    track.save
  end
end
