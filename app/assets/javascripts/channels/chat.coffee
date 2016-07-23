class CommonHelper
  @getURLParameter : (name, urlArgs = location.search) ->
    (new RegExp(name + '=' + '(.+?)(&|$)').exec(urlArgs) || [null, null])[1]


friend_id = CommonHelper.getURLParameter('friend_id')
App.chat = App.cable.subscriptions.create {channel: "ChatChannel", friend_id: friend_id},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $("#message-list").append data['message']

  speak: (data) ->
    @perform 'speak', data

$(document).on 'click', '.send-message', (event) ->
  friend_id = $("#friend-id").val()
  content = $("#msg-content").val()
  if content != ''
    App.chat.speak content: content, receiver_id: friend_id
  $("#msg-content").val('')
  event.preventDefault()