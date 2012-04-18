class Discovery.Routers.Playlists extends Backbone.Router
  initialize: () ->
    this.playlists = new Discovery.Collections.Playlists()
    this.playlists.fetch()
    view = new Discovery.Views.Layout(collection: this.playlists)
    window.activePlaylist = null

  routes:
    '': 'index'
    'playlists/:id': 'show'

  index: ->

  show: (id) ->
    if window.activePlaylist?
      window.activePlaylist.unbind()
      window.activePlaylist.remove()

    playlist = new Discovery.Models.Playlist(id: id)
    playlist.fetch success: (model) ->
      $('h2').html(model.attributes.search_term)
      playlist.tracks.fetch success: ->
        window.activePlaylist = new Discovery.Views.PlaylistsIndex(model: playlist)
        $('.player_container').html(window.activePlaylist.render().el)
        window.activePlaylist.initPlayer()
