class Discovery.Views.SongsIndex extends Backbone.View
  template: JST['songs/index']

  render: ->
    $(this.el).html(this.template(songs: this.collection))
    this
