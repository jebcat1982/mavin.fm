albums = 
{
  "http://featurelessghost.bandcamp.com/album/biologically-sound-cyber-bodies" => "acid,crash symbols,dance,electronic,ghost,pop,sci-fi,science fiction,synthpop,techno,Atlanta",
  "http://featurelessghost.bandcamp.com/album/new-moods" => "2011,dance,dark,electronic,featureless ghost,ghost,house,new wave,synthpop,Atlanta",
  "http://supergiantgames.bandcamp.com/album/bastion-original-soundtrack" => "acoustic frontier triphop,bastion,soundtrack,supergiant,videogame,San Jose,triphop",
  "http://theukeladies.bandcamp.com/album/the-ukeladies" => "dreamscape,faux,hawaiian,future,retro,tropical,Melbourne",
  "http://pickwick.bandcamp.com/album/myths-vol-1" => "r&b,alternative,pop,rock,soul,Seattle",
  "http://woodspider.bandcamp.com/album/in-the-thick-of-it" => "diy folk, folk punk, roots, vaudeville, accordion, acoustic, banjo, birthquake records, cello, freak folk, free download, lo-fi, new england gothic, ukuleler,New York",
  "http://treelines.bandcamp.com/album/self-titled" => "indie, rock, Vancouver",
  "http://questionsound.bandcamp.com/album/re-deux" => "beats, instrumentals, jazzy, hip hop, soul-jazz, California",
  "http://thewillowandthebuilder.bandcamp.com/album/the-willow-the-builder" => "adrian simon, folk, middletown, new haven, richard miron, the willow and the builder, wesleyan, yale, folk, indie, rock, Connecticut",
}

albums.each do |url,tags|
  album = Album.new(:url => url)

  tag_array = tags.split(',')
  tag_array.each do |name|
    name.strip!
    tag = Tag.find_or_create_by_name(name)
    album.taggings.build(:tag_id => tag.id)
  end

  album.save
end
