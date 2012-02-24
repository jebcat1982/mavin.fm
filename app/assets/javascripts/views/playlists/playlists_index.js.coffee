class Discovery.Views.PlaylistsIndex extends Backbone.View
  el: '#app_container'

  events:
    'click #next_song': 'getSong'
    'click #pause_song': 'pauseSong'
    'click #play_song': 'playSong'

  initialize: ->
    this.model.tracks.fetch()
    this.getSong()

  render: ->
    $('#songs').empty()
    this.model.tracks.each(this.prependSong)
    this

  prependSong: (song) ->
    model = new Discovery.Models.Song(song.get('track'))
    view = new Discovery.Views.Song(model: model)
    $('#songs').prepend(view.render().el)

  getSong: (e) ->
    e.preventDefault() if e
    view = this
    
    attributes = search_term: this.model.get('search_term')
    this.model.tracks.create attributes,
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
