class Discovery.Models.Playlist extends Backbone.Model
  url: ->
    base = 'playlists'
    if this.isNew() then return base
    if base.charAt(base.length-1) == '/'
      return base + this.id
    else
      return base + '/' + this.id

  initialize: () ->
    this.tracks = new Discovery.Collections.PlaylistTracks
    this.tracks.url = '/playlists/' + this.id + '/playlist_tracks'
    this.on 'change:id', () ->
      this.tracks.url = '/playlists/' + this.id + '/playlist_tracks'
