class Public::HomesController < ApplicationController
  def top
    if user_signed_in?
      # ステータスが有効かつフォローしているユーザーを全件取得
      @user = current_user
      @users = User.where(status: false) && @user.followings
      following_user_id = []
      following_user_id << current_user.id
      @users.each do |user|
        following_user_id << user.id
      end
      # 該当ユーザーの投稿を全件取得
      @posts = Post.where(user_id: following_user_id)
    else
      # ステータスが有効かつ公開ユーザーを全件取得
      @users = User.where(privacy: "1",status: false)
      released_user_id = []
      @users.each do |user|
        released_user_id << user.id
      end
      # 該当ユーザーの投稿を全件取得
      @posts = Post.where(user_id: released_user_id)
    end
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(8)
    
    # 地図上で投稿した市町村にポイントを打つ
    if user_signed_in?
      user_posts = current_user.posts
      user_post_town_id = []
      user_posts.each do |user_post|
        user_post_town_id << user_post.town_id
      end
      @towns = Town.where(id: user_post_town_id)
    end
  end
end
