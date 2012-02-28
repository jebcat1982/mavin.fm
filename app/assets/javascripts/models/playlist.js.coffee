class Discovery.Models.Playlist extends Backbone.Model
  url: '/playlists'

  initialize: () ->
    this.tracks = new Discovery.Collections.PlaylistTracks
    this.tracks.url = '/playlists/' + this.id + '/playlist_tracks'
    this.on 'change:id', () ->
      this.tracks.url = '/playlists/' + this.id + '/playlist_tracks'
