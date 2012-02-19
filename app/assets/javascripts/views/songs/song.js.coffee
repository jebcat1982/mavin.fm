class Discovery.Views.Song extends Backbone.View
  template: JST['songs/song']
  tagName: 'p'

  initialize: ->
    this.model.on('change', this.render, this)

  render: ->
    $(this.el).html(this.template(song: this.model))
    this