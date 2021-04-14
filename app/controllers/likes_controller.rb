class LikesController < ApplicationController
    before_action :set_likeable, only: [:new]

    def create
        likeable = nil
        if params[:post_id].present?
            likeable = Post.find(params[:post_id])
        end

        if params[:comment_id].present?
            likeable = Comment.find(params[:comment_id]) 
        end

        @like = Like.new(likeable: likeable, user: current_user)
        if @like.save
            redirect_to posts_path
        else
            redirect_to posts_path
        end
    end

    def destroy
        
    end

    private

end
