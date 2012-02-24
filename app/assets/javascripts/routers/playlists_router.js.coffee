class Discovery.Routers.Playlists extends Backbone.Router
  initialize: () ->
    this.playlists = new Discovery.Collections.Playlists()
    this.playlists.fetch()
    view = new Discovery.Views.Layout(collection: this.playlists)

  routes:
    '': 'index'
    'playlists/:id': 'show'

  index: ->

  show: (id) ->
    playlist = new Discovery.Models.Playlist(id: id)
    playlist.fetch success: ->
      playlist.tracks.fetch success: ->
        view = new Discovery.Views.PlaylistsIndex(model: playlist)
        view.render().el
