class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comments, only: [:new]
    
    def new
        @comment = Comment.new(post: @post)
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
            redirect_to new_post_comment_path(@post)
        end
    end 

    def destroy

    end

    private

    def set_post
        @post = Post.find(params[:post_id])
    end

    def set_comments
        @comments = Comment.where(post: @post)
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
