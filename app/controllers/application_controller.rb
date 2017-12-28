# class ApplicationController < ActionController::API
#   require 'json_web_token'

#   def authenticate_request!

#   end

#   def payload_token
#     @payload_token || = if request.headers['Authentication-Token'].present?
#                        request.headers['Authentication-Token'].split('.').last
#                      end
#   end

#   def session_info
#     @session_info || = json_web_token.decode(payload_token)
#   end

#   def validate_info
    
# end
