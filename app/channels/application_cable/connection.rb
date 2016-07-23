module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags current_user.email
    end

    def disconnect
      # Any cleanup work needed when the cable connection is cut.
    end

    protected
    def find_verified_user
      if (current_user = User.find cookies.signed[:user_id])
        current_user
      else
        # reject_unauthorized_connection
        nil
      end
    end
  end
end
