require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "viewing all posts" do
    sign_in users(:user1)
    
    get posts_path
    assert_response :success
    assert_select ".post", posts.size
  end

  test "viewing all posts that belong to a given user" do 
    user = users(:user1)
    sign_in user

    get user_posts_path(user)
    assert_response :success
    assert_select ".username" do |usernames|
      usernames.each do |username|
        assert_equal username.children.text, user.email, "wrong username"
      end
    end

    assert_select ".post", user.posts.size
  end

  test "creating a post" do
    sign_in users(:user1)

    get new_post_path
    assert_response :success
    
    new_post = Post.new(user: users(:user1), content: "The time is " + Time.now.to_f.to_s)
    post "/posts", params: { post: { content: new_post.content } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select ".post-content", new_post.content
  end

  test "editing post" do
    sign_in users(:user1)
    post = users(:user1).posts.first

    get edit_post_path(post)
    assert_response :success

    assert_select ".edit_post"

    new_post = Post.new(user: users(:user1), content: "The time is " + Time.now.to_f.to_s)
    patch post_path(post), params: { post: { content: new_post.content } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select ".post-content", new_post.content
  end

  test "deleting post from posts index page" do
    sign_in users(:user1)
    post = users(:user1).posts.first

    delete post_path(post)
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "#post-" + post.id.to_s, false, "this post should have been deleted"
    assert_equal path, posts_path, "redirected to the wrong page"
  end

  test "deleting post from the posts index page of a given user or from the new comment page of a given post" do
    user = users(:user1)

    sign_in user
    post = user.posts.first
    
    # the link to this path is only present on the posts index page of a given user (user_posts_path(user)) or a post's new comment page
    delete post_path(post), params: { user_id: user.id }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "#post-" + post.id.to_s, false, "this post should have been deleted"
    assert_equal path, user_posts_path(user), "redirected to the wrong page"
  end
end
