class Discovery.Routers.Songs extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    this.songs = new Discovery.Collections.Songs()
    this.songs.fetch()

    view = new Discovery.Views.SongsIndex(collection: this.songs)
    $('#song_container').html(view.render().el)
