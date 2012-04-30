class Discovery.Views.Song extends Backbone.View
  template: JST['songs/song']
  className: 'current'

  render: ->
    $('#songs .current').removeClass('current')
    $(this.el).html(this.template(song: this.model))
    this
