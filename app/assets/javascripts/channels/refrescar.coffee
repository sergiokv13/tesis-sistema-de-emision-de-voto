App.refrescar = App.cable.subscriptions.create "RefrescarChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    location.reload()
