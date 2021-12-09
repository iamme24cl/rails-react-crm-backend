class ApplicationController < ActionController::API
	include SessionAuthenticatable

  # Require session key authentication
  prepend_before_action :authenticate_with_session_key!
end
