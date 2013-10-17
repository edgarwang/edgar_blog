class SessionsController < ApplicationController
  layout 'auth'

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      @current_user = user
      redirect_to root_url, notice: 'Signed In!'
    else
      flash.now.alert = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    @current_user = nil
    redirect_to root_url, notice: 'Signed out!'
  end
end
