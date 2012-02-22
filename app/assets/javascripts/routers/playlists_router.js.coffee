class Discovery.Routers.Playlists extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    this.playlists = new Discovery.Collections.Playlists()
    this.playlists.fetch()

    view = new Discovery.Views.PlaylistsIndex(collection: this.playlists)
