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

    return false if json['error_message']

    uri = URI.parse(json['location'])
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)

    return false if json['error_message']

    if json['tracks']
      json['tracks'].each do |track|
        soundcloud_track(track, json['permalink_url'])
      end
    elsif json['track_count']
      uri = URI.parse("http://api.soundcloud.com/users/#{json['id']}/tracks.json?client_id=#{APIKeys::SOUNDCLOUD}")
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)
      json.each do |track|
        soundcloud_track(track)
      end
    else
      soundcloud_track(json)
    end
  end

  def soundcloud_track(json)
    track = Track.soundcloud_new(json)
    track.save

    @tags.each do |tag|
      track.taggings.build(:tag_id => tag.id)
      Discovery.redis.sadd "t#{track.id}", tag.id
    end

    track.save

    Discovery.redis.sadd "tracks", track.id
  end
end
