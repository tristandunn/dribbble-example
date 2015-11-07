class SessionsController < ApplicationController
  def new
    # Create an access token from the provided code.
    session[:token] = Token.create_from_code(params[:code])

    # Redirect back to the homepage.
    redirect_to root_path
  end
end
