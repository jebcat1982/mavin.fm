class Discovery.Views.Playlist extends Backbone.View
  template: JST['playlists/playlist']
  tagName: 'li'

  initialize: ->
    this.model.on('change', this.render, this)

  events: ->
    'click .playlist-name': 'setName'

  render: ->
    $(this.el).html(this.template(playlist: this.model))
    this.el.id = "playlist_#{this.model.id}"
    this

  setName: () ->
    $('h2').html(this.model.attributes.name)
