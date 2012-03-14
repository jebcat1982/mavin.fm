puts "Loading rails environment..."
require './config/environment.rb'

redis = Discovery.redis
playlists = Playlist.all
tracks = Track.all

puts "Looping through playlists..."
puts "#{playlists.count} playlists."
playlists.each do |p|
  pid = "p#{p.id}"

  tags = p.search_term.split(',')
  tags.each do |name|
    tag = Tag.find_or_create_by_name(name.strip)
    redis.sadd pid, tag.id
  end
end

puts "Looping through tracks..."
puts "#{tracks.count} tracks."
tracks.each do |t|
  redis.sadd "tracks", t.id
  tid = "t#{t.id}"

  tags = t.tags
  tags.each do |tag|
    redis.sadd tid, tag.id
  end
end
