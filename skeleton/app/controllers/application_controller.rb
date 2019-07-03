class ApplicationController < ActionController::Base
  
  before_action :ensure_logged_in
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil
  end

  def destroy
    User.find_by(session_token: session[:session_token])
    User.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def login_user!
    session[:session_token] = User.reset_session_token
  end

  private

  def ensure_logged_in
    redirect_to cats_url if self.logged_in?
  end
end
