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
    redirect_to mypage_path(post.user_id)
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
    @post = Post.find(params[:id])
    @towns = Town.all
    @categories = Category.all
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to mypage_show_path(@post.user_id)
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to mypage_show_path(post.user.id)
  end

private
  def post_params
    params.require(:post).permit(:image,:town_id,:category_id,:title,:star,:body)
  end

end
