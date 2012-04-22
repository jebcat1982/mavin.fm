class Discovery.Routers.Users extends Backbone.Router
  routes:
    'user/:username': 'showUser'

  showUser: (username) ->
    if window.activePlaylist?
      window.activePlaylist.unbind()
      window.activePlaylist.remove()
      window.activePlaylist = null

    user = new Discovery.Models.User(username: username)
    user.fetch success: (model) ->
      view = new Discovery.Views.UserIndex(model: model)
      $('.content_container').html(view.render().el)
