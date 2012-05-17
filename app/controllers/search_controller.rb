class SearchController < ApplicationController
  respond_to :html

  def index
  end

  def find
    if params[:query].index(' by ')
      # Find track
      split = params[:query].split(' by ')
      track = split[0].gsub(' ', '+')
      artist = split[1].gsub(' ', '+')
      uri = URI.parse("http://ws.audioscrobbler.com/2.0/?method=track.gettoptags&artist=#{artist}&track=#{track}&api_key=#{APIKeys::LASTFM}&autocorrect=1&format=json")
      resp = Net::HTTP.get(uri)
      json = JSON.parse(resp)

      track = KnownTrack.where(artist: json['toptags']['@attr']['artist'], name: json['toptags']['@attr']['track']).first
      track = KnownTrack.create(artist: json['toptags']['@attr']['artist'], name: json['toptags']['@attr']['track']) if track.nil?

      json['toptags']['tag'].each do |t|
        tag = Tag.find(:first, :conditions => [ "lower(name) = ? ", t['name'].downcase])
        unless tag.nil?
          track.tags << tag
          Discovery.redis.sadd "kt#{track.id}", tag.id
        end
      end
      track.save
      path = "#{track.name} by #{track.artist}".gsub(' ', '+')
    else
      # Find artist
      artist = params[:query].gsub(' ', '+')
      uri = URI.parse("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptags&artist=#{artist}&api_key=#{APIKeys::LASTFM}&autocorrect=1&format=json")
      resp = Net::HTTP.get(uri)
      json = JSON.parse(resp)

      artist = KnownArtist.find_or_create_by_name(json['toptags']['@attr']['artist'])
      
      json['toptags']['tag'].each do |t|
        tag = Tag.find(:first, :conditions => [ "lower(name) = ? ", t['name'].downcase])
        unless tag.nil?
          artist.tags << tag
          Discovery.redis.sadd "ka#{artist.id}", tag.id
        end
      end

      artist.save
      path = artist.name.gsub(' ', '+')
    end

    redirect_to search_results_path(query: path)
  end

  def results
    @query = params[:query].gsub('+', ' ')
    @similar = []
    if @query.index(' by ')
      # It's a track!
      track = @query.split(' by ')[0]
      artist = @query.split(' by ')[1]
      track = KnownTrack.find(:first, :conditions => [ "lower(artist) = ? AND lower(name) = ?", artist.downcase, track.downcase ])
      @similar = Track.find_known_similar("kt#{track.id}") unless track.nil?
    else
      # No it's an artist!
      artist = KnownArtist.find(:first, :conditions => [ "lower(name) = ?", @query.downcase ])
      @similar = Track.find_known_similar("ka#{artist.id}") unless artist.nil?
    end

    respond_with @similar
  end
end
