class Discovery.Routers.Playlists extends Backbone.Router
  initialize: () ->
    this.playlists = new Discovery.Collections.Playlists()
    this.playlists.fetch()
    view = new Discovery.Views.Layout(collection: this.playlists)
    window.activePlaylist = null

  routes:
    '': 'index'
    'playlists/:id': 'showPlaylist'
    'user/:username': 'showUser'

  index: ->

  showPlaylist: (id) ->
    if window.activePlaylist?
      window.activePlaylist.unbind()
      window.activePlaylist.remove()

    playlist = new Discovery.Models.Playlist(id: id)
    playlist.fetch success: (model) ->
      $('.user_container').hide()
      $('.music_container').show()

      $('h2').html(model.attributes.name)
      playlist.tracks.fetch success: ->
        window.activePlaylist = new Discovery.Views.PlaylistsIndex(model: playlist)
        $('.player_container').html(window.activePlaylist.render().el)
        window.activePlaylist.initPlayer()

  showUser: (username) ->
    if window.activePlaylist?
      window.activePlaylist.unbind()
      window.activePlaylist.remove()
      window.activePlaylist = null

    user = new Discovery.Models.User(username: username)
    user.fetch
      success: (model) ->
        $('.music_container').hide()
        $('.user_container').show()

        model.liked.fetch
          success: ->
            view = new Discovery.Views.UserIndex(model: model)
            $('.user_container').html(view.render().el)

      error: (model, response) ->
        $('.music_container').hide()
        $('.user_container').show()

        if response.status == 404
          $('.user_container').html(username + ' not found!')
        else
          $('.user_container').html('Sorry, something went wrong! Try again later')
