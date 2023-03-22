class Public::HomesController < ApplicationController
  def top
    @posts = Post.all
    @posts = Post.all.order(created_at: :desc)
  end
end
