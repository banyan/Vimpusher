class SessionsController < ApplicationController
  skip_before_filter :auth, only: [:callback]

  def new
  end

  def callback
    auth = request.env['omniauth.auth'].symbolize_keys
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid])

    if user
      session[:user_id] = user.id
      redirect_to "/#{current_user.username}"
    else
      store_auth_params(auth)
      redirect_to signup_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  def failure
    flash[:error] = "Authentication error: #{params[:message].humanize}"
    redirect_to login_path
  end

  private

  def store_auth_params(auth)
    paramz = auth.slice(:provider, :uid)
    paramz[:info] = auth[:info].symbolize_keys.slice(:email, :nickname, :name)
    session[:params_from_authenticator] = paramz
  end
end
