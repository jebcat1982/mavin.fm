class Discovery.Routers.Playlists extends Backbone.Router
  initialize: () ->
    this.bind 'all', this._trackPageview
    this.playlists = new Discovery.Collections.Playlists()
    this.playlists.fetch()
    view = new Discovery.Views.Layout(collection: this.playlists)
    window.activePlaylist = null

  routes:
    '': 'index'
    'playlists/:id': 'showPlaylist'
    'user/:username': 'showUser'

  _trackPageview: ->
    url = Backbone.history.getFragment()
    _gaq.push(['_trackPageview', "/#{url}"]) if typeof _gaq == 'object'

  index: ->
    $('.info_container').show()
    $('.user_container').hide()
    $('.music_container').hide()

  showPlaylist: (id) ->
    if window.activePlaylist?
      window.activePlaylist.unbind()
      window.activePlaylist.remove()

    playlist = new Discovery.Models.Playlist(id: id)
    playlist.fetch success: (model) ->
      $('.info_container').hide()
      $('.user_container').hide()
      $('.music_container').show()

      playlist.tracks.fetch success: ->
        window.activePlaylist = new Discovery.Views.PlaylistsIndex(model: playlist)
        $('.music_container').html(window.activePlaylist.render().el)
        $('h2#playlist_name').html(model.attributes.name)
        window.activePlaylist.initPlayer()
        window.activePlaylist.initSongs()

  showUser: (username) ->
    if window.activePlaylist?
      window.activePlaylist.unbind()
      window.activePlaylist.remove()
      window.activePlaylist = null

    user = new Discovery.Models.User(username: username)
    user.fetch
      success: (model) ->
        $('.info_container').hide()
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
