App.Views.AlbumView = Backbone.View.Extend
  initialize: () ->

  render: () ->
    this.$el.html(JST['albums/view']({ model: this.model }))
    return this
