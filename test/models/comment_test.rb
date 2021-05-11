require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "Can't create an empty comment" do
    comment = Comment.new(user: users(:user1), post: posts(:post1), content: "")
    assert_not comment.save, "Shouldn't be able to create an empty post!"
  end
end
