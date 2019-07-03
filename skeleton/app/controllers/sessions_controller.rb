class SessionsController < ApplicationController
  before_action :ensure_logged_in

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user
      user.login_user!
      redirect_to users_url
    else
      flash.now[:errors] = "Invalid password and/or username combination"
      render :new
    end
  end
end