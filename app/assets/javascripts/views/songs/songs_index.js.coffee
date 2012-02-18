class Discovery.Views.SongsIndex extends Backbone.View
  template: JST['songs/index']

  initialize: ->
    this.collection.on('all', this.render, this)

  render: ->
    $(this.el).html(this.template(songs: this.collection))
    this
