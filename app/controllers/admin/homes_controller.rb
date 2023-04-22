class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @posts = Post.all
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(8)
  end
end
