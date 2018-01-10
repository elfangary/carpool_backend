module ApplicationCable
  class Connection < ActionCable::Connection::Base
    require 'json_web_token'
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected
    def find_verified_user
      if current_user = User.find(session_info[:user_id])
        current_user
      else
        reject_unauthorized_connection
      end
    end

    def session_info
      JsonWebToken.decode(request.params[:token])
    end



  end 
end
