class LikesController < ApplicationController
    before_action :set_likeable, only: [:create]

    def create
        @like = Like.new(likeable: @likeable, user: current_user)
        
        js_file_path = "likes/create-" + @like.likeable_type.downcase + "-like.js.erb"
        
        if @like.save
            respond_to do |format|
                format.js { render js_file_path }
            end
        end
    end

    def destroy
        @like = Like.find(params[:id])
        js_file_path = "likes/destroy-" + @like.likeable_type.downcase + "-like.js.erb"
        @like.destroy

        respond_to do |format|
            format.js { render js_file_path }
        end
    end

    private

    def set_likeable
        if params[:post_id].present?
            @likeable = Post.find(params[:post_id])
        end

        if params[:comment_id].present?
            @likeable = Comment.find(params[:comment_id]) 
        end
    end

end
