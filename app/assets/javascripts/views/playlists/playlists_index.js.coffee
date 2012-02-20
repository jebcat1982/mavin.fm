class Discovery.Views.PlaylistsIndex extends Backbone.View
  template: JST['playlists/index']

  events:
    'submit #new_playlist': 'createPlaylist'
    'click #next_song': 'get_song'
    'click #pause_song': 'pauseSong'
    'click #play_song': 'playSong'

  initialize: ->
    this.collection.on('reset', this.render, this)

  render: ->
    $(this.el).html(this.template(playlists: this.collection))
    this

  createPlaylist: (e) ->
    e.preventDefault()
    attributes = search_term: $('#new_playlist_search_term').val()
    this.collection.create attributes
    this.getSong()

  getSong: (e) ->
    e.preventDefault() if e
    playlist = this
    song = new Discovery.Collections.Songs()
    song.fetch success: (c, r) -> 
      playlist.startSong(c)

  startSong: (song) ->
    view = new Discovery.Views.Song(model: song.models[0])
    $('#songs').prepend(view.render().el)
    $('#player')[0].src = song.models[0].get('streaming_url')
    $('#player')[0].play()

  pauseSong: (e) ->
    e.preventDefault()
    $('#player')[0].pause()

  playSong: (e) ->
    e.preventDefault()
    $('#player')[0].play()
