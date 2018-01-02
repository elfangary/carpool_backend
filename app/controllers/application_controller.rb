class ApplicationController < ActionController::API
  require 'json_web_token'

  def authenticate_request!
    if !current_user.present?
      render json: { message: 'You must be authenticated first'}, status: :unauthorized
    end
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { message: 'Stop hacking'}, status: :unauthorized
  end

  private
  def jwt_token
    @jwt_token ||= request.headers['Authentication_Token']
  end

  def session_info
    @session_info ||= JsonWebToken.decode(jwt_token)
  end

  def current_user
    @current_user ||= User.find session_info[:user_id]
    rescue ActiveRecord::RecordNotFound
      nil
  end
end
