class Discovery.Views.UserIndex extends Backbone.View
  template: JST['users/index']

  render: ->
    $(this.el).html(this.template(user: this.model))
    this
