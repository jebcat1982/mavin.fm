class Discovery.Views.Layout extends Backbone.View
  el: '#app_container'

  events:
    'submit #new_playlist': 'createPlaylist'

  initialize: ->
    this.collection.on('reset', this.render, this)
    this.active = null

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
      success: (model) ->
        playlistView = new Discovery.Views.Playlist(model: model)
        $('#playlists').prepend(playlistView.render().el)
        router.navigate("playlists/#{model.id}", trigger: true)
