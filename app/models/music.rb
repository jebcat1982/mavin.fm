class Music
  attr_accessor :url, :tags, :album_id

  def initialize(url = nil, tags = nil)
    self.url = url
    self.tags = tags
  end

  def save
    uri = URI.parse(self.url)
    split_tags()
    bandcamp()   if uri.host.index('bandcamp.com')
    soundcloud() if uri.host.index('soundcloud.com')
  end

  def bandcamp
    get_album() if self.url.index('/albums/')
    get_track() if self.url.index('/track/')
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

  # These are methods for calling several different Bandcamp API modules in order to retrieve all of
  # the information on a band and album. Bandcamp API docs are located at http://bandcamp.com/developer

  # Makes a request to the URL module. This module will take a Bandcamp URL and resolve it to a 
  # Bandcamp band_id and a Bandcamp album_id
  def url_module
    uri = URI.parse("http://api.bandcamp.com/api/url/1/info?key=#{APIKeys::BANDCAMP}&url=#{self.url}")
    response = Net::HTTP.get(uri)
    @info = JSON.parse(response)
  end

  # Takes the Bandcamp band_id from the url_module and makes a request to the band module. This retrieves
  # all of the band information from Bandcamp such as name, offsite_url, etc.
  def band_module
    @band = Band.find_or_create_by_e_id(@info["band_id"])
    uri = URI.parse("http://api.bandcamp.com/api/band/3/info?key=#{APIKeys::BANDCAMP}&band_id=#{@band.e_id}")
    response = Net::HTTP.get(uri)
    band = JSON.parse(response)

    @band.offsite_url  = band["offsite_url"]
    @band.url          = band["url"]
    @band.subdomain    = band["subdomain"]
    @band.name         = band["name"]
    @band.save

    # Return the parsed JSON for the rspec test
    band
  end

  # Takes the album_id from the url_module and makes a request to the album module. This retrieves
  # all of the album information such as the artwork, free or not, and all of the album's tracks.
  def album_module
    album_id = @info["album_id"] || self.album_id
    uri = URI.parse("http://api.bandcamp.com/api/album/2/info?key=#{APIKeys::BANDCAMP}&album_id=#{album_id}")
    response = Net::HTTP.get(uri)
    @album_info = JSON.parse(response)
  end

  def track_module
    uri = URI.parse("http://api.bandcamp.com/api/track/3/info?key=#{APIKeys::BANDCAMP}&track_id=#{@info['track_id']}")
    response = Net::HTTP.get(uri)
    @track_info = JSON.parse(response)
  end

  # Calls each module method and stores the information to the model before saving. Also builds all
  # of the tracks into the album model before saving.
  def get_album
    url_module()
    band_module()
    album_module()

    @album = Album.new

    @album.title         = @album_info["title"]
    @album.release_date  = @album_info["release_date"]
    @album.downloadable  = @album_info["downloadable"]
    @album.url           = @album_info["url"]
    @album.about         = @album_info["about"]
    @album.credits       = @album_info["credits"]
    @album.small_art_url = @album_info["small_art_url"]
    @album.large_art_url = @album_info["large_art_url"]
    @album.artist        = @album_info["artist"] || @band.name
    @album.band_id       = @band.id
    @album.e_id          = @album_info["album_id"]
    @album.e_band_id     = @album_info["band_id"]

    build_tracks()

    @album.save
  end
  
  def get_track
    url_module()
    band_module()
    track_module()
    if @track_info['album_id']
      self.album_id = @track['album_id']
      get_album()
    else
      @track = Track.new

      @track.title          = @track_info['title']
      @track.number         = @track_info['number']
      @track.duration       = @track_info['duration']
      @track.release_date   = @track_info['release_date']
      @track.downloadable   = @track_info['downloadable']
      @track.url            = @track_info['info']
      @track.streaming_url  = @track_info['streaming_url']
      @track.lyrics         = @track_info['lyrics']
      @track.about          = @track_info['about']
      @track.credits        = @track_info['credits']
      @track.small_art_url  = @track_info['small_art_url']
      @track.large_art_url  = @track_info['large_art_url']
      @track.artist         = @track_info['artist']
      @track.e_id           = @track_info['track_id']
      @track.e_album_id     = @track_info['album_id']
      @track.e_band_id      = @track_info['band_id']

      @tags.each do |tag|
        @track.taggings.build(:tag_id => tag.id)
      end

      @track.save
    end
  end

  def build_tracks
    @album_info["tracks"].each do |track|
      # If the tracks don't have these values take them from the album
      downloadable  = track["downloadable"]  || @album.downloadable
      small_art_url = track["small_art_url"] || @album.small_art_url
      large_art_url = track["large_art_url"] || @album.large_art_url
      artist        = track["artist"]        || @album.artist         || @band.name

      @album.tracks.build(
        :title         => track["title"],
        :number        => track["number"],
        :duration      => track["duration"],
        :release_date  => track["release_date"],
        :downloadable  => downloadable,
        :url           => track["url"],
        :streaming_url => track["streaming_url"] + "&api_key=#{APIKeys::BANDCAMP}",
        :lyrics        => track["lyrics"],
        :about         => track["about"],
        :credits       => track["credits"],
        :small_art_url => small_art_url,
        :large_art_url => large_art_url,
        :artist        => artist,
        :e_id          => track["track_id"],
        :e_album_id    => track["album_id"],
        :e_band_id     => track["band_id"],

        :album_title   => @album.title,
        :album_url     => @album.url,
        :artist_url    => @band.url,
        :band_subdomain => @band.subdomain
      )

      @album.tracks.each do |track|
        @tags.each do |tag|
          track.taggings.build(:tag_id => tag.id)
        end
      end
    end
  end
end
