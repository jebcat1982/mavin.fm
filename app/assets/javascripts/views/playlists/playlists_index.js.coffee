class Discovery.Views.PlaylistsIndex extends Backbone.View
  template: JST['playlists/index']
  className: 'player_container'

  events:
    'click #next_song': 'getSong'
    'click #pause_song': 'pauseSong'
    'click #play_song': 'playSong'

  initialize: ->
    this.getSong()
    view = this
    $('#player').on 'timeupdate', () -> view.songTime()
    $('#player').on 'ended', () -> view.songEnded()

  render: ->
    $(this.el).html(this.template())
    this.model.tracks.each(this.prependSong)
    this

  prependSong: (song) ->
    if song.get('track')
      model = new Discovery.Models.Song(song.get('track'))
      view = new Discovery.Views.Song(model: model)
      $('#songs').prepend(view.render().el)

  getSong: (e) ->
    e.preventDefault() if e
    view = this

    $('#songs').prepend("<div class='loading'></div>")
    
    attributes = search_term: this.model.get('search_term')
    this.model.tracks.create attributes,
      success: (model) ->
        song = new Discovery.Models.Song(model.attributes)
        view.startSong(song)

  startSong: (song) ->
    view = new Discovery.Views.Song(model: song)
    $('.loading').remove()
    $('#songs').prepend(view.render().el)
    $('#player')[0].src = song.get('streaming_url')
    $('#player')[0].play()

  pauseSong: (e) ->
    e.preventDefault()
    $('#player')[0].pause()

  playSong: (e) ->
    e.preventDefault()
    $('#player')[0].play()

  songTime: () ->
    #$('#player')[0].currentTime

  songEnded: () ->
    this.getSong()
