class Discovery.Models.User extends Backbone.Model
  url: ->
    base = 'user'
    if this.isNew() then return base
    if base.charAt(base.length-1) == '/'
      return base + this.attributes.username
    else
      return base + '/' + this.attributes.username

