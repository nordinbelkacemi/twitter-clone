require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "creating a like on a post" do
    sign_in users(:user2)
    post = users(:user1).posts.first
    likes_before = post.likes.size

    post post_likes_path(post), xhr: true
    assert_response :success
    likes_after = post.likes.size

    assert_equal likes_after, likes_before + 1, "The number of likes was not incremented"
  end

  test "creating a like on a comment" do
    sign_in users(:user1)
    comment = comments(:comment1)
    likes_before = comment.likes.size

    post comment_likes_path(comment), xhr: true
    assert_response :success
    likes_after = comment.likes.size

    assert_equal likes_after, likes_before + 1, "The number of likes was not incremented"
  end
  
  test "deleting a like on a post" do
    test_deleting_like_on(likes(:post_like1))
  end

  test "deleting a like on a comment" do
    test_deleting_like_on(likes(:comment_like1))
  end

  private
  
  def test_deleting_like_on(like)
    sign_in like.user
    likes_before = like.likeable.likes.size
    
    delete like_path(like), xhr: true
    assert_response :success
    likes_after = like.likeable.likes.size

    assert_equal likes_after, likes_before - 1, "The number of likes was not decremented"
  end
end
