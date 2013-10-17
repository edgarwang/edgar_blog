class SessionsController < ApplicationController
  layout 'auth'
  skip_before_filter :verify_authenticity_token, only: [:create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      @current_user = user
    else
      flash.now.alert = "Invalid email or password"
      render 'new'
    end
  end

  def destroy
    @current_user = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
