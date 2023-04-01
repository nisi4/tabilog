class Public::FavoritesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        post = Post.find(params[:post_id])
        favorite = current_user.favorites.new(post_id: post.id)
        favorite.save
        redirect_back(fallback_location: root_path)
    end
    
    def destroy
        post = Post.find(params[:post_id])
        favorite = current_user.favorites.find_by(post_id: post.id)
        favorite.destroy
        redirect_back(fallback_location: root_path)
    end
    
    def index
        @user = User.find(params[:user_id])
        @user_posts = @user.posts
        
        favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
        @posts = Post.find(favorites)
    end
end
