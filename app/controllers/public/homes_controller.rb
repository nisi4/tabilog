class Public::HomesController < ApplicationController
  def top
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
end
