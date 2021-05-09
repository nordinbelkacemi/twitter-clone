class PostsController < ApplicationController
    before_action :set_user, only: [:index]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if !@post.save
            alert_invalid_input
            redirect_to new_post_path(@post)
        else
            redirect_to user_posts_path(current_user)
        end
    end

    def index
        if @user.nil?
            @posts = Post.all
        else
            @posts = Post.where(user: @user)
        end

        @posts = @posts.sort_by { |post| post.created_at }.reverse
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if !@post.update(post_params)
            alert_invalid_input
            redirect_to edit_post_path(@post)
        else
            redirect_to user_posts_path(current_user)
        end

    end

    def destroy
        @post = Post.find(params[:id])
        if @post.destroy
            if params[:user_id].present?
                user = User.find(params[:user_id])
                redirect_to user_posts_path(user)
            else
                redirect_to posts_path
            end
        end
    end

    private

    def set_user
        if params[:user_id].present?
            @user = User.find(params[:user_id])
        end
    end

    def post_params
        params.require(:post).permit(:content)
    end

    def alert_invalid_input
		flash[:alert] = "Invalid input"
	end
end
