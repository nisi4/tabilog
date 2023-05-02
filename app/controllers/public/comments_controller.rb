class Public::CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @post = Post.find(params[:post_id])
        @comment = Comment.new
    end
    
    def create
        post = Post.find(params[:post_id])
        comment = Comment.new(post_comment_params)
        comment.user_id = current_user.id
        comment.post_id = post.id
        comment.save
        redirect_to request.referer
    end
    
    def destroy
        Comment.find(params[:id]).destroy
        redirect_to request.referer
    end
    
    private
    def post_comment_params
        params.require(:comment).permit(:comment)
    end
end
