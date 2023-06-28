class Public::FavoritesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @post = Post.find(params[:post_id])
        favorite = current_user.favorites.new(post_id: @post.id)
        favorite.save
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        favorite = current_user.favorites.find_by(post_id: @post.id)
        favorite.destroy
    end
    
    def index
        favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
        @posts = Post.where(id: favorites)
        @posts = @posts.page(params[:page]).per(4)
    end
end
