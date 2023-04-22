class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @user = User.new
    @users = User.all
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:status)
  end
end
