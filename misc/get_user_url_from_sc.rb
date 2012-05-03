require 'json'

puts "Loading rails environment..."
require './config/environment.rb'

tracks = Track.where(source: 'sc')

puts "Fixing soundcloud tracks..."

tracks.each_with_index do |track,i|
  uri = URI.parse("http://api.soundcloud.com/tracks/#{track.e_id}.json?client_id=#{APIKeys::SOUNDCLOUD}")
  resp = Net::HTTP.get(uri)
  json = JSON.parse(resp)

  track.artist_url = json['user']['permalink_url']
  track.save
end
