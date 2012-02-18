class Discovery.Views.PlaylistsIndex extends Backbone.View
  template: JST['playlists/index']

  initialize: ->
    this.collection.on('reset', this.render, this)

  render: ->
    $(this.el).html(this.template(playlists: this.collection))
    this
