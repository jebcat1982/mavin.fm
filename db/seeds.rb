albums = []
albums << {"http://featurelessghost.bandcamp.com/album/biologically-sound-cyber-bodies" => "acid,crash symbols,dance,electronic,ghost,pop,sci-fi,science fiction,synthpop,techno,Atlanta"}
albums << {"http://featurelessghost.bandcamp.com/album/new-moods" => "2011,dance,dark,electronic,featureless ghost,ghost,house,new wave,synthpop,Atlanta"}
albums << {"http://supergiantgames.bandcamp.com/" => "acoustic frontier triphop,bastion,soundtrack,supergiant,videogame,San Jose,triphop"}
albums << {"http://theukeladies.bandcamp.com/" => "dreamscape,faux,hawaiian,future,retro,tropical,Melbourne"}
albums << {"http://pickwick.bandcamp.com/album/myths-vol-1" => "r&b,alternative,pop,rock,soul,Seattle"}
albums << {"http://woodspider.bandcamp.com/" => "diy folk, folk punk, roots, vaudeville, accordion, acoustic, banjo, birthquake records, cello, freak folk, free download, lo-fi, new england gothic, ukuleler,New York"}
albums << {"http://3crates.bandcamp.com/" => "hip hop/rap, hip hop, pop, rock, soul, Philadelphia"}
albums << {"http://treelines.bandcamp.com/album/self-titled" => "indie, rock, Vancouver"}
albums << {"http://questionsound.bandcamp.com/album/re-deux" => "beats, instrumentals, jazzy, hip hop, soul-jazz, California"}
albums << {"http://thewillowandthebuilder.bandcamp.com/" => "adrian simon, folk, middletown, new haven, richard miron, the willow and the builder, wesleyan, yale, folk, indie, rock, Connecticut"}

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
