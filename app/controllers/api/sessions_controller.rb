class Api::SessionsController < ApplicationController
  include SessionAuthenticatable

  # Require session key authentication
  prepend_before_action :authenticate_with_session_key!, only: %i[check_if_logged_in destroy]

  def check_if_logged_in
    user = User.find_by(id: current_bearer.id)
    if user
      render json: user, status: 200
    else
      render json: { message: 'Please log in!'}, status: 403
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session = user.sessions.create! token: SecureRandom.hex
      render json: session, status: 201
    else
      render json: { error: "Invalid Credentials. Check your email and password!" }, status: 401
    end
  end

  def destroy
    session = current_bearer.sessions.find(params[:id])

    session.destroy
    render json: { message: "Successfully logged out"}, status: 200
  end
end
