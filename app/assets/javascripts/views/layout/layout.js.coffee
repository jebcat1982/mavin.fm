class Discovery.Views.Layout extends Backbone.View
  el: '#app_container'

  events:
    'click #new_playlist_link': 'createPlaylist'
    'click #random_playlist_link': 'createRandomPlaylist'

  initialize: ->
    this.collection.on('reset', this.render, this)

  render: ->
    this.collection.each(this.prependPlaylist)
    this

  prependPlaylist: (playlist) ->
    view = new Discovery.Views.Playlist(model: playlist)
    this.$('#playlists').prepend(view.render().el)

  createPlaylist: (e) ->
    e.preventDefault()
    view = this

    attributes = search_term: $('#new_playlist_search_term').val()
    this.collection.create attributes,
      wait: true
      success: (model) ->
        playlistView = new Discovery.Views.Playlist(model: model)
        $('#playlists').prepend(playlistView.render().el)
        router.navigate("playlists/#{model.id}", trigger: true)

  createRandomPlaylist: (e) ->
    e.preventDefault()
    view = this

    attributes = search_term: ''
    this.collection.create attributes,
      wait: true
      success: (model) ->
        playlistView = new Discovery.Views.Playlist(model: model)
        $('#playlists').prepend(playlistView.render().el)
        router.navigate("playlists/#{model.id}", trigger: true)
