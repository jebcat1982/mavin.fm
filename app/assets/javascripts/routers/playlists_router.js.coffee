class Discovery.Routers.Playlists extends Backbone.Router
  initialize: () ->
    this.playlists = new Discovery.Collections.Playlists()
    this.playlists.fetch()
    view = new Discovery.Views.PlaylistsIndex(collection: this.playlists)

  routes:
    '': 'index'
    'playlists/:id': 'show'

  index: ->

  show: (id) ->
    alert "playlist #{id}"
