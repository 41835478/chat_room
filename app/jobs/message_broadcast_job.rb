class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ids = [message.sender_id, message.receiver_id]
    # Do something later
    ActionCable.server.broadcast "chat_channel_#{ids.join('_')}", message: render_message(message, message.sender)
    ActionCable.server.broadcast "chat_channel_#{ids.reverse.join('_')}", message: render_message(message, message.receiver)
  end

  private
  def render_message(message, current_user)
    ApplicationController.renderer.render(partial: "messages/message", locals: { message: message, current_user: current_user })
  end
end
