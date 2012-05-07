class Discovery.Views.Layout extends Backbone.View
  el: '#app_container'

  events:
    'click #new_playlist_link': 'createPlaylist'
    'click #random_playlist_link': 'createRandomPlaylist'
    'click #playlists .delete': 'deletePlaylist'

  initialize: ->
    this.collection.on('reset', this.render, this)
    this.lastCreated = undefined

  render: ->
    this.collection.each(this.prependPlaylist)
    this

  prependPlaylist: (playlist) ->
    view = new Discovery.Views.Playlist(model: playlist)
    this.$('#playlists').prepend(view.render().el)

  createPlaylist: (e) ->
    e.preventDefault()
    view = this

    time = new Date()
    time = time.getTime()

    return if time - this.lastCreated < 5000 && this.lastCreated != undefined

    attributes = search_term: $('#new_playlist_search_term').val()
    this.collection.create attributes,
      wait: true
      success: (model) ->
        newTime = new Date()
        view.lastCreated = newTime.getTime()
        playlistView = new Discovery.Views.Playlist(model: model)
        $('#playlists').prepend(playlistView.render().el)
        router.navigate("playlists/#{model.id}", trigger: true)

  createRandomPlaylist: (e) ->
    e.preventDefault()
    view = this

    time = new Date()
    time = time.getTime()

    return if time - this.lastCreated < 5000 && this.lastCreated != undefined

    attributes = search_term: ''
    this.collection.create attributes,
      wait: true
      success: (model) ->
        newTime = new Date()
        view.lastCreated = newTime.getTime()
        playlistView = new Discovery.Views.Playlist(model: model)
        $('#playlists').prepend(playlistView.render().el)
        router.navigate("playlists/#{model.id}", trigger: true)

  deletePlaylist: (e) ->
    e.preventDefault()
    id = $(e.currentTarget).data('playlist')
    this.collection.remove(id)
    $("#playlist_#{id}").remove()
    $.ajax "/playlists/#{id}", type: 'delete'
    if id == window.activePlaylist.model.id
      window.activePlaylist.unbind()
      window.activePlaylist.remove()
      window.activePlaylist = null
      router.navigate("")

