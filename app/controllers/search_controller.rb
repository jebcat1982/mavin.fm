class SearchController < ApplicationController
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
        end
      end

      artist.save
      path = artist.name.gsub(' ', '+')
    end

    redirect_to search_path
  end

  def results
  end
end
