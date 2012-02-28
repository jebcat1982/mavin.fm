class Discovery.Views.Song extends Backbone.View
  template: JST['songs/song']

  render: ->
    $(this.el).html(this.template(song: this.model))
    this
