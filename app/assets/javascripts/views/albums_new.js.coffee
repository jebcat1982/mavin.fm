App.Views.AlbumView = Backbone.View.extend
  initialize: () ->

  render: () ->
    this.$el.html(JST['albums/new']({ model: this.model }))
    return this
