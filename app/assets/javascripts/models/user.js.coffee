class Discovery.Models.User extends Backbone.Model
  url: ->
    base = 'user'
    if base.charAt(base.length-1) == '/'
      return base + this.attributes.username
    else
      return base + '/' + this.attributes.username

  initialize: ->
    this.disliked = new Discovery.Collections.DislikedTracks
    this.liked = new Discovery.Collections.LikedTracks
    this.disliked.url = '/user/' + this.attributes.username + '/disliked'
    this.liked.url = '/user/' + this.attributes.username + '/liked'
