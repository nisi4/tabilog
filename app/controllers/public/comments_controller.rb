class Public::CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @post = Post.find(params[:post_id])
        @comment = Comment.new
    end
    
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(post_comment_params)
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
        if @comment.save
            redirect_to request.referer
        else
            render :index
        end
    end
    
    def destroy
        comment = Comment.find(params[:id])
        if comment.user_id = current_user.id
            comment.destroy    
        end
        redirect_to request.referer
    end
    
    private
    def post_comment_params
        params.require(:comment).permit(:comment)
    end
end
