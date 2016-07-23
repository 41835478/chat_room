module ContactsHelper
  def unread_tag(sender_id, receiver_id)
    cnt = Message.unread_count(sender_id, receiver_id)
    unread_class = (cnt > 0 ? 'unread' : '')
    content_tag(:span, cnt, class: "badge #{unread_class}")
  end
end
