module SessionAuthenticatable
  extend ActiveSupport::Concern
 
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
 
  attr_reader :current_session_key
  attr_reader :current_bearer
 
  # Use this to raise an error and automatically respond with a 401 HTTP status
  # code when session key authentication fails
  def authenticate_with_session_key!
    @current_bearer = authenticate_or_request_with_http_token &method(:authenticator)
  end
 
  # Use this for optional session key authentication
  def authenticate_with_session_key
    @current_bearer = authenticate_with_http_token &method(:authenticator)
  end
 
  private
 
  attr_writer :current_session_key
  attr_writer :current_bearer
 
  def authenticator(http_token, options)
    @current_session_key = Session.authenticate_by_token http_token 
 
    current_session_key&.bearer
  end
end