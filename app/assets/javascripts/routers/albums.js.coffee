App.Routers.Albums = Backbone.Router.extend
  routes:
    "": "index"
    "albums/add": "add"

  index: () ->
    console.log "Woo, working!"

  add: () ->
    console.log "Woo, super working!"
