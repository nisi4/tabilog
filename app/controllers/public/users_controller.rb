class Public::UsersController < ApplicationController
  before_action :sign_out_user, if: :user_signed_in?
  before_action :is_matching_login_user,except: [:index]
  
  def index
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(4)
    @visit_town = @posts.distinct.count(:town_id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(4)
    @visit_town = @posts.distinct.total_count(:town_id)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to mypage_show_path(user.id)
  end
  
  def release
    @user = User.find(params[:id])
    @user.released! unless @user.released?
    redirect_to mypage_show_path(@user.id)
  end
  
  def nonrelease
    @user = User.find(params[:id])
    @user.nonreleased! unless @user.nonreleased?
    redirect_to mypage_show_path(@user.id)
  end
  
  def leave
    user = User.find(params[:id])
    user.update(status: true)
    redirect_to mypage_path(user.id)
  end
  
  private
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path(current_user.id)
    end
  end
  
  def user_params
    params.require(:user).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:user_name,:profile_image,:introduction,:email)
  end
  
  def sign_out_user
    sign_out_and_redirect(current_user) if current_user.status == true
  end

end
