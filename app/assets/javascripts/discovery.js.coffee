window.Discovery =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Discovery.Routers.Songs()
    Backbone.history.start()

$(document).ready ->
  Discovery.init()
