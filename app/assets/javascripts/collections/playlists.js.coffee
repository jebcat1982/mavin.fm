class Discovery.Collections.Playlists extends Backbone.Collection
  url: '/playlists'

  initialize: ->
    this.active = null
