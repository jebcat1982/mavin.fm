class Discovery.Routers.Playlists extends Backbone.Router
  routes:
    '': 'index'
    'playlists/:id': 'show'

  index: ->
    this.playlists = new Discovery.Collections.Playlists()
    this.playlists.fetch()

    view = new Discovery.Views.PlaylistsIndex(collection: this.playlists)

  show: (id) ->
    alert "playlist #{id}"
