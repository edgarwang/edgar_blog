class SessionsController < ApplicationController
  layout 'sessions'

  def new
    redirect_to dashboard_root_url unless session[:user_id].blank?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_root_url
    else
      flash[:error] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'Signed out!'
    redirect_to root_url
  end
end
