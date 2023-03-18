class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @user = current_user
    @towns = Town.all
  end
  
  def create
  end

  def index
  end

  def edit
  end
  
  def update
  end
  
end
