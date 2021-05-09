require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should_get_posts" do
    sign_in users(:user1)

    byebug
    get posts_url
    assert_response :success
    assert_response :redirect
  end
end
