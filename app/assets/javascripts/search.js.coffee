$(document).ready ->
  $('#jplayer_search').jPlayer swfPath: '/Jplayer.swf'

  $('.track .play').click (e)->
    e.preventDefault()

    $('.stop').hide()
    $('.play').show()

    $('#jplayer_search').jPlayer('stop')
    $('#jplayer_search').jPlayer('setMedia', mp3: $(this).data('location'))
    $('#jplayer_search').jPlayer('play')
    $(this).next('.stop').show()
    $(this).hide()

  $('.track .stop').click (e)->
    e.preventDefault()

    $(this).hide()
    $(this).prev('.play').show()

    $('#jplayer_search').jPlayer('stop')
