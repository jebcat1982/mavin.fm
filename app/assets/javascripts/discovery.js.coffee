window.Discovery =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Discovery.Routers.Playlists()
    Backbone.history.start()

$(document).ready ->
  Discovery.init()
