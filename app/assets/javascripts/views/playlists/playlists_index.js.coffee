class Discovery.Views.PlaylistsIndex extends Backbone.View
  template: JST['playlists/index']

  events:
    'submit #new_playlist': 'create_playlist'
    'click #next_song': 'get_song'

  initialize: ->
    this.collection.on('reset', this.render, this)

  render: ->
    $(this.el).html(this.template(playlists: this.collection))
    this

  create_playlist: (e) ->
    e.preventDefault()
    attributes = search_term: $('#new_playlist_search_term').val()
    this.collection.create attributes
    this.get_song()

  get_song: (e) ->
    e.preventDefault() if e
    playlist = this
    song = new Discovery.Collections.Songs()
    song.fetch success: (c, r) -> 
      playlist.play_song(c)

  play_song: (song) ->
    view = new Discovery.Views.Song(model: song.models[0])
    $('#songs').prepend(view.render().el)
    $('#player')[0].src = song.models[0].get('streaming_url')
    $('#player')[0].play()
