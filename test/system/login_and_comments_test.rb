require "application_system_test_case"

class LoginAndCommentsTest < ApplicationSystemTestCase
  test "logs in and comments" do
    # user logs in
    visit home_path
    assert_equal page.current_path, home_path

    within ".home-content" do
      click_on "Log in"
    end
    assert_equal page.current_path, new_user_session_path

    fill_in "Email", with: users(:user1).email
    fill_in "Password", with: "123123"
    within ".user-form" do
      click_on "Log in"
    end
    assert_selector "a", text: "Log out"
    assert_equal page.current_path, posts_path
    
    
    # user clicks on the comments link of a post, and creates a comment
    post = Post.first
    post_selector = "#post-" + post.id.to_s
    within post_selector do
      click_on class: "comment-link"
    end
    assert_equal page.current_path, new_post_comment_path(post)

    content = Time.now.to_f.to_s
    fill_in "Write a new comment", with: content
    click_on "Create Comment"
    assert_equal page.current_path, new_post_comment_path(post)
    assert_selector ".comment-content", text: content
  end
end
