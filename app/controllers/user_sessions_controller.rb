class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:users, notice: 'Login successful')
    else
      redirect_to login_path, alert: 'Login failed'
    end
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]
  end

  def create_from_provider
    omniauth = env['omniauth.auth']
    logger.debug "+++ #{omniauth}"

    user = User.find_by_uid(omniauth['uid'])
    if not user
      # New user registration
      user = User.new(uid: omniauth['uid'], password: '123456', password_confirmation: '123456')
    end
    user.email = omniauth['info']['email']
    user.save

    auto_login(user)

    redirect_back_or_to(root_path, notice: 'Login successful')
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end

  def login_with_contactability
    if current_user
      redirect_to root_path
    else
      respond_to do |format|
        format.html  {
          redirect_to '/auth/sso'
        }
        format.json {
          render :json => { 'error' => 'Access Denied' }.to_json
        }
      end
    end
  end
end
