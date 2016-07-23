# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    logger.info "current connections.count: #{ActionCable.server.connections.count}"
    ids = [current_user.id, params['friend_id']]
    stream_from "chat_channel_#{ids.join('_')}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def speak(data)
    # after save message content, do send message
    Message.create! content: data['content'], sender_id: current_user.id, receiver_id: data['receiver_id']
  end
end
