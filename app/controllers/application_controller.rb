class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  protected
  
  helper_method :current_user, :signed_in?
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def require_signed_in!
    unless signed_in?
      redirect_to root_url, alert: 'Please sign in first'
    end
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  def must_has_one_user
    redirect_to sign_up_url unless User.count > 0
  end
end
