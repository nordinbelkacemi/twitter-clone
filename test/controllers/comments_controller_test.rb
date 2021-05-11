require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "create a comment" do
    user = users(:user1)
    post = posts(:post1)

    sign_in user

    get new_post_comment_path(post)
    assert_response :success
    
    content = "The time is " + Time.now.to_f.to_s
    new_comment = Comment.new(user: user, content: content )
    post post_comments_path(post), params: { comment: { content: new_comment.content } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select ".comment-content", text: content
  end

  test "edit a comment" do
    comment = comments(:comment1)
    user = comment.user

    sign_in user

    get edit_post_comment_path(comment.post, comment)
    assert_response :success
    
    content = "The time is " + Time.now.to_f.to_s
    new_comment = Comment.new(user: user, content: content )
    patch post_comment_path, params: { comment: { content: new_comment.content }, post_id: comment.post.id, id: comment.id }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    assert_select ".comment-content", text: content
  end

  test "delete a comment" do
    comment = comments(:comment1)
    sign_in comment.user

    delete post_comment_path(comment.post, comment)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    assert_select "#comment-" + comment.id.to_s, false, "this comment should have been deleted"
  end
end
