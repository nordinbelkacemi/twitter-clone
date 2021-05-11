require "test_helper"

class PostAndCommentTest < ActionDispatch::IntegrationTest
  test "create post and comment on it" do
    get home_path
    assert_response :success
    assert_select ".btn", text: "Log in"

    get new_user_session_path
    assert_response :success
    assert_select "form", class: "new_user"

    sign_in users(:user1)
    
    get home_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select ".post", Post.count

    get new_post_path
    assert_response :success
    assert_select ".content-form"

    new_post = Post.new(user: users(:user1), content: "The time is " + Time.now.to_f.to_s)
    post "/posts", params: { post: { content: new_post.content } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select ".post-content", new_post.content
  end
end
