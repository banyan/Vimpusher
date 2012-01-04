class UsersController < ApplicationController
  verify :session => :params_from_authenticator, :only => %w(new create), :redirect_to => :login_path
  before_filter :login_required, :only => %w(edit update)

  def index
    @users = User.all
    @vimrcs = Vimrc.all
    @user_for_gravatar = User.order("id DESC").limit(80).map

    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new_with_omniauth(session[:params_from_authenticator])
  end

  def show
    @user    = User.find params[:username]
    @plugins = @user.plugin_urls

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new_with_omniauth(session[:params_from_authenticator])
    @user.attributes = params[:user]

    if @user.save
      session[:user_id] = @user.id
      session.delete(:params_from_authenticator)
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @user.vimrcs.build if @user.vimrcs.empty?
    @user.gitmodules.build if @user.gitmodules.empty?
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        Resque.enqueue(Crawler, @user.id)
        format.html { redirect_to settings_path, notice: 'Settings was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
