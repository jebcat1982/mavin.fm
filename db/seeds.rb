music = 
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
  "http://kinack.bandcamp.com/album/ondas" => "chillout, downtempo, electronic, instrumental, kinack, nu jazz, ondas, trip hop, trip-hop, trip-hop, triphop, Colorado",
  "http://qiwutheqiwuselftet.bandcamp.com/album/travelling-arri-re" => "hip hop/rap, jazz hip hop, trip hop, acid jazz, beatmaker, hip hop instrumentals, instrumental hip hop, qiwu, triphop",
  "http://thirdpersonlurkin.bandcamp.com/album/the-cloud-mirror" => "electronic, idm, downtempo, experimental, experimental electronic, experimental hip-hop, hiphop, idm experimental down-tempo, instrumental hiphop, lounge, triphop, United Kingdom",
  "http://saintphonik.bandcamp.com/album/instrus" => "hip hop/rap, hiphop, instrumentals, rap, triphop, beatmaking, braka, hip-hop, hiphop, instrumentals, montreal, quebec, rap, speats, Montreal",
  "http://clay1.bandcamp.com/album/fractal-music" => "downtempoi, dubb, electronic, glitch, glitchstep, triphop, Santa Cruz",
  "http://thirdpersonlurkin.bandcamp.com/album/the-nameless-city" => "electronic, ambient, breakbeat, downtempo, experimental, hiphop, instrumental hip hop, instrumental hip-hop, lounge, trip-hop, triphop, United Kingdom",
  "http://marcello.bandcamp.com/album/ein-fenster-zur-strasse-ep" => "hip hop/rap, absztrakkt, berlin, deutschrap, funkviertel, hiphop, instrumental, marcello, rap, triphop, x-men klan, Berlin",
  "http://thirdpersonlurkin.bandcamp.com/album/the-strange-light-district" => "electronic, ambient, breakbeat, downtempo, experimental, hiphop, instrumental hip hop, instrumental hip-hop, lounge, trip-hop, triphop, United Kingdom",
  "http://timeresonancemusic.bandcamp.com/album/the-neverland" => "downtempo, dubstep, electronic, glitch, idm, triphop, ambient, chillout, deep, downtempo, dubstep, electronic, funk, idm, jazzy, psychedelic, Russian Federation",
  "http://gsoul.bandcamp.com/album/730-infinite-legacy" => "arlan, bustaphort, g-soul, hip hop/rap, chillout, downtempo, jazzy hip hop, nujabes, soulful, triphop, Spain",
  "http://poldoore.bandcamp.com/album/waiting-for-the-world-free-ep" => "chillout, downtempo, funk, hip hop/rap, instrumental, hip-hop, lounge, triphop, downtempo, instrumental, instrumental hiphop, lounge, poldoore, trip hop, trip-hop, triphop, waiting for the world, Leuven",
  "http://manateecommune.bandcamp.com/album/ep" => "ambient,bedroom,commune,dreampop,lo-fi,manatee,triphop,electronic,Bellingham",
  "http://illusionisten.bandcamp.com/album/syndende-engel-angrende-djaevel" => "hiphop,horrorcore,poetry,rap,triphop,Copenhagen",
  "http://aisuru.compactmusic.de/album/aisuru-one" => "electronic,bass,dubstep,electronica,future bass,glitch,glitch-hop,hip hop,idm,lounge,love,triphop,Berlin",
  "http://aisuru.compactmusic.de/album/aisuru-two" => "electronic,dubstep,electronica,glitch,glitchhop,hiphop,idm,love,triphop,Berlin",
  "http://brokeforfree.bandcamp.com/album/directionless-ep" => "chill,electronic,glitch,glitch-hop,hip hop,trip-hop,downtempo,electronic,glitch-hop,hiphop,midtempo,triphop,Santa Cruz",
  "http://eddieallamand.com/album/from-heart-to-space-free" => "electronic,classical, downtempo, eddie allamand, electronica, from heart to space, hip-hop, instrumental, piano, trip-hop, triphop, Lausanne",
  "http://timeresonancemusic.bandcamp.com/album/boldness-of-dream" => "alexander dancaless, dancaless, downtempo, dubstep, electronic. glitch, idm, triphop, downtempo, dubstep, electronic, electronica, idm, triphop, vocal, Russian Federation",
  "http://mrmoods.bandcamp.com/album/cinematic-beats-free-download" => "abstract, hip hop, hip hop/rap, trip hop, abstract, abstract beats, abstract hip-hop, ambient, cinematic, soundscape, downtempo jazz, lounge, mrmoods, soundscape, soundtrack, triphop, Laval",
  "http://timeresonancemusic.bandcamp.com/album/rainbow-place" => "deep flow, downtempo, dubstep, ed7, electronic, glitch, idm, triphop, ambient, atmosphere, atmospheric, electronic, electronica, soundscape, Russian Federation",
  "http://shop.lucky-time.com/album/golden-jazzyland" => "nu jazz, acid jazz, downbeat, downtempo, electronic, hip-hop instrumental, jazzy, jazzy hip hop, nu jazz, trip hop, triphop, Russian Federation",
  "http://lookingglassrecords.bandcamp.com/album/the-clandestine-experiment" => "ambient, cindergarden, darkwave, goth, industrial, soundtrack, synthpop, triphop, Los Angeles"
}

music.each do |url,tags|
  m = Music.new(url,tags)
  m.save
end
