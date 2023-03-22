class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @user = current_user
    @towns = Town.all
    @categories = Category.all
  end
  
  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
    @posts = Post.all.order(created_at: :desc)
  end

  def edit
  end
  
  def update
  end

private
  def post_params
    params.require(:post).permit(:image,:town_id,:category_id,:title,:star,:body)
  end

end
