class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :settings

  def login_required
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def logged_in?
    current_user.present?
  end

  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find_by_id session[:user_id] if session[:user_id]
  end

  def settings
    # use icon via gravatar.com
    @gravatar_url = User.find(current_user.id).gravatar_url if logged_in?
  end
end
