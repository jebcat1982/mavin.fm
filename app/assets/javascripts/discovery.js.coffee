window.Discovery =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    window.router = new Discovery.Routers.Playlists()
    Backbone.history.start()

$(document).ready ->
  Discovery.init()
