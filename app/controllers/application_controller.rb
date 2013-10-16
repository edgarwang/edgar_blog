class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  protected
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def sign_in?
    !!current_user
  end
  helper_method :current_user, :sign_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end
end
