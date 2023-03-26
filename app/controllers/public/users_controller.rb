class Public::UsersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
end
