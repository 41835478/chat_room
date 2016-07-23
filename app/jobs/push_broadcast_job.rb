class PushBroadcastJob < ApplicationJob
  queue_as :push

  def perform(message)
    contact = Contact.where(owner_id: message.receiver_id, member_id: message.sender_id).first
    # Do something later
    ActionCable.server.broadcast "push_channel_#{message.receiver_id}",
      { member_id: message.sender_id, contact: render_contact(contact) }
  end

  private
  def render_contact(contact)
    ApplicationController.renderer.render(partial: 'contacts/contact', locals: { contact: contact, current_user: contact.owner })
  end
end
