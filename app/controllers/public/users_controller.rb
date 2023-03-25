class Public::UsersController < ApplicationController
  def index
    @user_post = current_user.posts
    @posts = @user_post.all
    @user = User.find(params[:id])
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
end
