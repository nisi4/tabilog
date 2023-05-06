class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @user = current_user
    @towns = Town.all
    @categories = Category.all
  end
  
  def create
    @post = Post.new(post_params)
    if town_exist = Town.find_by(town_name: @post.town_name)
      @post.town_id = town_exist.id
    else
      @post.town_id = nil
    end
    @post.user_id = current_user.id
    if @post.save
      redirect_to mypage_path(@post.user_id)
    else
      @user = current_user
      @towns = Town.all
      @categories = Category.all
      render :new
    end
  end

  def index
    # 公開ユーザーを全件取得
    @users = User.where(privacy: "1",status: false)
    released_user_id = []
    @users.each do |user|
      released_user_id << user.id
    end
    # 公開ユーザーの投稿を全件取得
    @posts = Post.where(user_id: released_user_id)
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(8)
  end
  
  def search_keyword
    # 公開ユーザーを全件取得
    @users = User.where(privacy: "1",status: false)
    released_user_id = []
    @users.each do |user|
      released_user_id << user.id
    end
    # 公開しているユーザーかつ、キーワードが入った投稿を探す
    @posts = Post.search(params[:keyword]).where(user_id: released_user_id)
    
    # ここは params[:sort]が存在しているかどうかチェックするのが正しい
    if params[:sort] == "likes" || params[:sort] == "dislikes"
      @posts = @posts.post_sort(params[:sort]).page(params[:page]).per(8)
    else
      @posts = @posts.order(created_at: :desc).page(params[:page]).per(8)
    end
    
    @keyword = params[:keyword]
    render "index"
  end
  
  def check_traveller
    @users = User.check(params[:traveller]).where(status: false)
    @traveller = params[:traveller]
    
  end

  def edit
    @post = Post.find(params[:id])
    @towns = Town.all
    @categories = Category.all
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if town_exist = Town.find_by(town_name: @post.town_name)
      @post.update(town_id: town_exist.id)
    else
      @post.update(town_id: nil)
    end
    user_id = current_user.id
    redirect_to mypage_show_path(user_id)
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to mypage_show_path(post.user.id)
  end

private
  def post_params
    params.require(:post).permit(:image,:town_id,:category_id,:title,:star,:body,:town_name)
  end

end
