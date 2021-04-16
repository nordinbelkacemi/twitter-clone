class PostsController < ApplicationController
    def new

    end

    def create

    end

    def index
        @posts = Post.all
        # Post.all.each do |post|
        #     liked = Like.where(likeable: post, user: current_user).any?
        #     posts << {post: post, liked: liked}
        # end
    end

    def edit
        
    end

    def update

    end

    def destroy

    end
end
