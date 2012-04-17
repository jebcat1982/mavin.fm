class Discovery.Views.Playlist extends Backbone.View
  template: JST['playlists/playlist']
  tagName: 'li'

  initialize: ->
    this.model.on('change', this.render, this)

  render: ->
    $(this.el).html(this.template(playlist: this.model))
    this
