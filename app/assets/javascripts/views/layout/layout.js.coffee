class Discovery.Views.Layout extends Backbone.View
  el: '#app_container'

  events:
    'submit #new_playlist': 'createPlaylist'
    'click #next_song': 'getSong'
    'click #pause_song': 'pauseSong'
    'click #play_song': 'playSong'

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
        router.navigate("playlists/#{model.id}")
        view.active = new Discovery.Models.Playlist(model)
        view.getSong()
        playlistView = new Discovery.Views.Playlist(model: view.active)
        $('#playlists').prepend(playlistView.render().el)

  getSong: (e) ->
    e.preventDefault() if e
    view = this
    
    attributes = search_term: this.active.get('search_term')
    this.active.tracks.create attributes,
      success: (model) ->
        song = new Discovery.Models.Song(model.attributes)
        view.startSong(song)

  startSong: (song) ->
    view = new Discovery.Views.Song(model: song)
    $('#songs').prepend(view.render().el)
    $('#player')[0].src = song.get('streaming_url')
    $('#player')[0].play()

  pauseSong: (e) ->
    e.preventDefault()
    $('#player')[0].pause()

  playSong: (e) ->
    e.preventDefault()
    $('#player')[0].play()
