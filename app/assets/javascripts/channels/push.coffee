App.push = App.cable.subscriptions.create "PushChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    target = $("#member-#{data['member_id']}")
    if target.length == 0
      $("#contacts").prepend(data['contact'])
    else
      target.replaceWith(data['contact'])
