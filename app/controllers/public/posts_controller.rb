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
    # 公開ユーザーを全件取得
    @users = User.where(privacy: "1")
    released_user_id = []
    @users.each do |user|
      released_user_id << user.id
    end
    # 公開ユーザーの投稿を全件取得
    @posts = Post.where(user_id: released_user_id)
    @posts = Post.where(user_id: released_user_id).order(created_at: :desc)
  end
  
  def search_keyword
    # 公開ユーザーを全件取得
    @users = User.where(privacy: "1")
    released_user_id = []
    @users.each do |user|
      released_user_id << user.id
    end
    @posts = Post.search(params[:keyword]).where(user_id: released_user_id)
    @posts = Post.search(params[:keyword]).where(user_id: released_user_id).order(created_at: :desc)
    @keyword = params[:keyword]
    
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
