class Discovery.Views.PlaylistsIndex extends Backbone.View
  template: JST['playlists/index']

  events:
    'click #next_song': 'getNextSong'
    'click #pause_song': 'pauseSong'
    'click #play_song': 'playSong'
    'click .like-song': 'like'
    'click .dislike-song': 'dislike'

  initialize: ->
    this.song = undefined
    this.wait = true

  render: ->
    $(this.el).html(this.template())
    this.model.tracks.each(this.prependSong)
    this

  initPlayer: () ->
    view = this
    $('#jplayer').jPlayer
      ready: () -> view.getSong()
      swfPath: '/Jplayer.swf'
    $('#jplayer').bind $.jPlayer.event.timeupdate, (e) -> view.songTime(e.jPlayer.status.currentTime)
    $('#jplayer').bind $.jPlayer.event.ended, () -> view.songEnded()

  prependSong: (song) ->
    if song.get('track')
      model = new Discovery.Models.Song(song.get('track'))
      view = new Discovery.Views.Song(model: model)
      $('#songs').prepend(view.render().el)

  getNextSong: (e) ->
    e.preventDefault() if e
    return if this.wait
    this.getSong()

  getSong: (e) ->
    e.preventDefault() if e
    view = this

    $('#songs').prepend("<div class='loading'></div>")
    
    attributes = search_term: this.model.get('search_term')
    this.model.tracks.create attributes,
      success: (model) ->
        $('#duration').html("0:00")
        view.song = new Discovery.Models.Song(model.attributes)
        view.wait = false
        view.startSong(view.song)

  startSong: (song) ->
    view = new Discovery.Views.Song(model: song)

    $('#current_song_name').html(song.get 'title')
    $('#current_time').html("0:00")
    duration = song.get('duration')
    seconds = Math.floor(duration % 60)
    seconds = "0" + seconds if seconds < 10
    minutes = Math.floor(duration / 60)
    $('#duration').html(minutes + ":" + seconds)
    $('.progress .bar').width("0%")

    $('.loading').remove()
    $('#songs').prepend(view.render().el)
    $('#jplayer').jPlayer('setMedia', mp3: song.get 'streaming_url')
    $('#jplayer').jPlayer('play')

  pauseSong: (e) ->
    e.preventDefault()
    $('#jplayer').jPlayer('pause')

  playSong: (e) ->
    e.preventDefault()
    $('#jplayer').jPlayer('play')

  songTime: (current) ->
    seconds = Math.floor(current % 60)
    seconds = "0" + seconds if seconds < 10
    minutes = Math.floor(current / 60)
    $('#current_time').html(minutes + ":" + seconds)
    $('.progress .bar').width((current / this.song.get('duration')) * 100 + "%")

  songEnded: () ->
    this.getSong()

  like: (e) ->
    e.preventDefault()
    $(e.currentTarget).addClass('liked') if !$(e.currentTarget).hasClass('liked')
    $(e.currentTarget.nextElementSibling).removeClass('disliked')
    $.post '/likes',
      playlist_id: this.model.id
      track_id: e.currentTarget.getAttribute('data-song')

  dislike: (e) ->
    e.preventDefault()
    $(e.currentTarget).addClass('disliked') if !$(e.currentTarget).hasClass('disliked')
    $(e.currentTarget.previousElementSibling).removeClass('liked')
    $.post '/dislikes',
      playlist_id: this.model.id
      track_id: e.currentTarget.getAttribute('data-song')

