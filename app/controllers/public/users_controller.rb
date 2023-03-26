class Public::UsersController < ApplicationController
  before_action :is_matching_login_user,except: [:index]
  
  def index
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @posts = @user.posts.all.order(created_at: :desc)
    @visit_town = @posts.distinct.count(:town_id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @posts = @user.posts.all.order(created_at: :desc)
    @visit_town = @posts.distinct.count(:town_id)
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path(current_user.id)
    end
  end
  
end
