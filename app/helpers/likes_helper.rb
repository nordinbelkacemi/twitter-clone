module LikesHelper
    def is_like_count_on_left(like)
        like.likeable_type == "Comment"
    end

    def new_like_path(likeable)
        if likeable.class == Comment
            comment_likes_path(likeable)
        elsif likeable.class == Post
            post_likes_path(likeable)
        end
    end
end
