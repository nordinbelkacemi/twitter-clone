require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "Cannot create an empty post" do
    post = Post.new(user: users(:user1), content: "")
    assert_not post.save, "Shouldn't be able to create an empty post!"
  end
end
