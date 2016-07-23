class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  after_create_commit {
    MessageBroadcastJob.perform_later self
    PushBroadcastJob.perform_later self
  }

  class << self
    def room_num(id1, id2)
      [id1, id2].map(&:to_i).sort.join('_')
    end

    def unread_count(sender_id, receiver_id)
      Message.where("receiver_id=? and sender_id=? and read_at is null", receiver_id, sender_id).count
    end
  end
end
