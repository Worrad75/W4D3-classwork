class UsersController < ApplicationController

  before_action :ensure_logged_in

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(users_params)
    # debugger
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      # debugger
      render :new
    end
  end


  private
  
  def users_params
    params.require(:user).permit(:user_name, :password)
  end

end