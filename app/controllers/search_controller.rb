class SearchController < ApplicationController
  def index
  end

  def find
    if params[:query].index('by') && params[:query].index('by') > 1
      # Find track or album
    else
      # Find artist
      artist = params[:query].gsub(' ', '+')
      uri = URI.parse("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptags&artist=#{artist}&api_key=#{APIKeys::LASTFM}&autocorrect=1&format=json")
      resp = Net::HTTP.get(uri)
      json = JSON.parse(resp)

      artist = KnownArtist.find_or_create_by_name(json['toptags']['@attr']['artist'])
      
      json['toptags']['tag'].each do |t|
        tag = Tag.find(:first, :conditions => [ "lower(name) = ? ", t['name']])
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
