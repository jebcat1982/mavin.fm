class Discovery.Views.PlaylistsIndex extends Backbone.View
  template: JST['playlists/index']

  events:
    'submit #new_playlist': 'create_playlist'

  initialize: ->
    this.collection.on('reset', this.render, this)

  render: ->
    $(this.el).html(this.template(playlists: this.collection))
    this

  create_playlist: (e) ->
    e.preventDefault()
    attributes = search_term: $('#new_playlist_search_term').val()
    this.collection.create attributes

    song = new Discovery.Collections.Songs()
    song.fetch()

    view = new Discovery.Views.SongsIndex(collection: song)
    $('#songs').html(view.render().el)
