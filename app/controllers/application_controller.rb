class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?
  

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logged_in?
    current_user
  end

  def logout!(user)
    user.reset_session_token! if logged_in?
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
end
