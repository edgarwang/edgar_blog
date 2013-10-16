class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    auth = request.env['omniauth.auth']
    @current_user = User.find_with_omniauth(auth)
    redirect_to root_url
  end

  def destroy
    @current_user = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
