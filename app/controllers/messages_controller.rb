class MessagesController < ApplicationController
  def list
    @friend = User.find params[:friend_id]
    field_values = [params[:friend_id], current_user.id]*2
    # find messages by sender and receiver, and order by created_at
    @messages = Message.where('(sender_id=? and receiver_id=?) or (receiver_id=? and sender_id=?)', *field_values).order("created_at desc").limit(20)

    unread_ids = @messages.collect {|msg|
      msg.id if msg.read_at.nil? && msg.receiver_id == current_user.id
    }.compact

    Message.where(id: unread_ids, receiver_id: current_user.id).update_all(read_at: Time.now)
  end
end
