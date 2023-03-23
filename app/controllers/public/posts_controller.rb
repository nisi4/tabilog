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
  
  def search_keyword
    @posts = Post.search(params[:keyword])
    @posts = Post.search(params[:keyword]).order(created_at: :desc)
    @keyword = params[:keyword]
    render "index"
  end
  
  def search_name
    @posts = Post.search(params[:name])
    @posts = Post.search(params[:name]).order(created_at: :desc)
    @name = params[:name]
    render "index"
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
