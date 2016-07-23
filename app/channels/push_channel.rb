# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PushChannel < ApplicationCable::Channel
  def subscribed
    logger.info "current connections.count: #{ActionCable.server.connections.count}"
    stream_from "push_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
