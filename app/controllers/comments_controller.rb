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
        if !@comment.save
            alert_invalid_input
        end
        redirect_to new_post_comment_path(@post)
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def update
        @comment = Comment.find(params[:id])
        if !@comment.update(comment_params)
            alert_invalid_input
        end
        redirect_to new_post_comment_path(@post)
    end

    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            redirect_to new_post_comment_path(@post)
        end
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

    def alert_invalid_input
		flash[:alert] = "Invalid input"
	end
end
